import java.util.concurrent.locks.ReentrantLock;
import java.time.Duration;
import java.time.Instant;

public class LightInterface extends Thread {
    PApplet parent;
    WebsocketClient wsc;
    ReentrantLock lock;
    StrobeLightSettings strobeSettings;
    ColorSettings LEDColor;
    LightMode mode = LightMode.OFF;
    PulseSettings pulseSettings;
    GlitterSettings glitterSettings;
    float aliveLedStrength = 0;
    float lightStrength    = 1;
    LightDeviceDiscover deviceDiscoverer;
    Instant lastContact;
    LightInterface(PApplet parent) {
        this.parent           = parent;
        this.lock             = new ReentrantLock();
        this.LEDColor         = new ColorSettings((byte)0, (byte)0, (byte)0);
        this.strobeSettings   = new StrobeLightSettings(0, 0);
        this.pulseSettings    = new PulseSettings(0, PulseDirection.IN, true);
        this.glitterSettings  = new GlitterSettings(0, false, 0);
        this.deviceDiscoverer = new LightDeviceDiscover();
        this.lastContact = Instant.now();
    }

    public void run() {
        while(true)
        {
          this.lock.lock();
          Duration timeSinceConnected = Duration.between(this.lastContact, Instant.now());
          this.lock.unlock();

          if(timeSinceConnected.getSeconds() >= 1)
          {
            this.reConnect();
          }

          this.sendMessage(this.getModeMessage());
          this.sendMessage(this.getAliveLedStrengthMessage());
          this.sendMessage(this.pulseSettings.getMessage());
          this.sendMessage(this.strobeSettings.getMessage());
          this.sendMessage(this.glitterSettings.getMessage());
          delay(50);
        } 
    }
    
    public void setColor(ColorSettings _color)
    {
      this.LEDColor = _color;
    }

    public void setMode(LightMode mode)
    {
      this.mode = mode;
    }
    
    public void setLightStrength(float strength)
    {
      this.lightStrength = strength;
    }

    public void setAliveLEDStrength(float strength)
    {
      this.aliveLedStrength = strength;
    }

    public void setStrobeSettings(StrobeLightSettings settings)
    {
      this.strobeSettings = settings;
    }

    public void setPulseSettings(PulseSettings settings)
    {
      this.pulseSettings = settings;
    }

    public void setGlitterSettings(GlitterSettings settings)
    {
      this.glitterSettings = settings;
    }
      
    private byte[] getModeMessage()
    {
      byte data[] = new byte[9];
      data[0] = LightInterfaceMessage.LIGHT_MODE.getValue();
      data[1] = this.mode.getValue();
      Serializer.serializeFloatLE(this.lightStrength, data, 2);
      data[6] = this.LEDColor.r;
      data[7] = this.LEDColor.g;
      data[8] = this.LEDColor.b;
      return data;
    }
  
      private byte[] getAliveLedStrengthMessage()
    {
      byte data[] = new byte[5];
      data[0] = LightInterfaceMessage.ONBOARD_LED_STRENGTH.getValue();
      Serializer.serializeFloatLE(this.aliveLedStrength, data, 1);
      return data;
    }


    private void sendMessage(byte[] data)
    {
      try
      {
        this.lock.lock();
        wsc.sendMessage(data);
      } catch(Exception e) {
      }
      this.lock.unlock();
    }

    private void reConnect() {
      this.lock.lock();
      try {
        String url = this.deviceDiscoverer.getURL();
        if(url.length() > 0)
        {
          System.out.println("Connecting to " + url);
          this.wsc = new WebsocketClient(this.parent, this, url);
          System.out.println("Connected to " + url);
          this.lastContact = Instant.now();
        }
        else
        {
          System.out.println("No light device discovered");
        }
      } catch(Exception e) {
        System.out.println("Connection failed");
      }

      this.lock.unlock();
    }

    public void webSocketEvent(byte[] payload, int offset, int length){
      this.lock.lock();
      this.lastContact = Instant.now();
      this.lock.unlock();
    }

    public void webSocketEvent(String msg){
      this.lock.lock();
      this.lastContact = Instant.now();
      this.lock.unlock();
    }
}