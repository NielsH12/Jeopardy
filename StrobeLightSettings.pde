class StrobeLightSettings {
  int on_time_us;
  int off_time_us;
  
  StrobeLightSettings(int _on_time_us, int _off_time_us)
  {
    this.on_time_us   = _on_time_us;
    this.off_time_us  = _off_time_us;
  }

  public byte[] getMessage()
  {
    byte data[] = new byte[9];
    data[0] = LightInterfaceMessage.STROBE.getValue();
    Serializer.serializeIntLE(this.on_time_us, data, 1);
    Serializer.serializeIntLE(this.off_time_us, data, 5);
    return data;
  }

}