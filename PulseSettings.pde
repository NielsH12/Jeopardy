enum PulseDirection {
  OUT(-1),
  IN(1);

  private final int value;

  private PulseDirection(int value) {
    this.value = value;
  }

  public byte getValue()
  {
    return (byte)this.value;
  }
}

class PulseSettings {
  int pulse_time_ms;
  PulseDirection direction;
  boolean single_shot;
  
  PulseSettings(int pulse_time_ms, PulseDirection direction, boolean single_shot)
  {
    this.pulse_time_ms = pulse_time_ms;
    this.direction = direction;
    this.single_shot = single_shot;
  }

  public byte[] getMessage()
  {
    byte data[] = new byte[7];
    data[0] = LightInterfaceMessage.PULSE_SETTINGS.getValue();
    Serializer.serializeIntLE(this.pulse_time_ms, data, 1);
    data[5] = this.direction.getValue();
    data[6] = this.single_shot ? (byte)1 : (byte)0;
    return data;
  }
}