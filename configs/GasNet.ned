package gasnet;
import inet.node.inet.StandardHost;
import inet.linklayer.ethernet.EtherHub;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;

network GasNet
{
    parameters:
        int numUAV = default(1);
    submodules:
        groundHost: StandardHost {
            @display("p=100,300");
        }
        satHost: StandardHost {
            @display("p=600,50");
        }
        uav[numUAV]: StandardHost {
            @display("p=350,180");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            serializerType = "inet::physicallayer::Ieee80211ScalarTransmitter";
        }
}
