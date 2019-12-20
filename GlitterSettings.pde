class GlitterSettings {
  int update_rate_ms;
  boolean random_color;
  float percent_on;
  
  GlitterSettings(int update_rate_ms, boolean random_color, float percent_on)
  {
    this.update_rate_ms = update_rate_ms;
    this.random_color = random_color;
    this.percent_on = percent_on;
  }

  public byte[] getMessage()
  {
    byte data[] = new byte[10];
    data[0] = LightInterfaceMessage.GLITTER.getValue();
    Serializer.serializeIntLE(this.update_rate_ms, data, 1);
    data[5] = this.random_color ? (byte)1 : (byte)0;

    Serializer.serializeFloatLE(this.percent_on, data, 6);
    return data;
  }
}