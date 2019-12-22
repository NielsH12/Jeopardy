import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.jmdns.JmDNS;
import javax.jmdns.ServiceEvent;
import javax.jmdns.ServiceListener;

class LightDeviceDiscover {

    private class Listener implements ServiceListener {
        @Override
        public void serviceAdded(ServiceEvent event) {
            System.out.println("Service added: " + event.getInfo());
        }

        @Override
        public void serviceRemoved(ServiceEvent event) {
            System.out.println("Service removed: " + event.getInfo());
        }

        @Override
        public void serviceResolved(ServiceEvent event) {
            System.out.println("Service resolved: " + event.getInfo());
        }
    }
    public JmDNS jmdns;
    LightDeviceDiscover() {
        try {
            // Create a JmDNS instance
            jmdns = JmDNS.create(InetAddress.getLocalHost());

            // Add a service listener
            jmdns.addServiceListener("_ws._tcp.local.", new Listener());

        } catch (UnknownHostException e) {
            System.out.println(e.getMessage());
        } catch (IOException e) {
            System.out.println(e.getMessage());
        } 
    }

    public String getURL()
    {
        ServiceInfo[] infos = this.jmdns.list("_ws._tcp.local.");
          for (int i = 0; i < infos.length; i++) {
              String name = infos[i].getName();
              String url = infos[i].getURL();
              if(name.contains("lightcontrolconfig") && 
                 !url.contains("0.0.0.0")            &&
                 url.contains(":80"))
              {
                  return url.replace("http", "ws");
              }
          }
        return "";
    }
}