#include "NetworkStream.h"

#include <cv_bridge/cv_bridge.h>

NetworkStream::NetworkStream(QObject *parent)
    : QObject(parent),
      socket(NULL)

{
  // Set up the publisher we will use to get gaze data in ROS.
  ros::NodeHandle nh;
  image_transport::ImageTransport it(nh);
  imPublisher = it.advertise("EyeRecTooImage", 1);
}

NetworkStream::~NetworkStream()
{
    if (socket)
        stop();
}

void NetworkStream::start(int port, QString ip)
{
    qInfo() << "Starting network stream"
             << "@" << ip
             << ":" << port;
    this->ip = ip;
    this->port = port;

    socket = new QUdpSocket(this);
    if (ip.compare("broadcast", Qt::CaseInsensitive ) == 0) {
        socket->bind(QHostAddress::Broadcast, port);
        socket->connectToHost(QHostAddress::Broadcast, port);
    } else {
        socket->bind(QHostAddress(ip), port);
        socket->connectToHost(QHostAddress(ip), port);
    }
    socket->setSocketOption(QAbstractSocket::LowDelayOption, 1);
}

void NetworkStream::stop()
{
    socket->deleteLater();
    socket = NULL;
}

void NetworkStream::push(DataTuple dataTuple)
{
    // Before the data vector push, also publish the current 
    // field widget image.
    sensor_msgs::ImagePtr msg = cv_bridge::CvImage(
      std_msgs::Header(), 
      "bgr8", dataTuple.field.input
    ).toImageMsg();

    imPublisher.publish(msg);

    // And now the data vector to UDP.
    if (!socket)
        return;

    static Timestamp lastPush = 0;

    Timestamp cur = gTimer.elapsed();
    if (cur - lastPush < 30)
        return;
    lastPush = cur;

    QString dataStr = dataTuple.toQString();
    dataStr.prepend("J");
    dataStr.append(gDataNewline);
    socket->write(dataStr.toUtf8());
}
