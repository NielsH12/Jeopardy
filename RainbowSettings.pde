class RainbowSettings {
  int update_rate_ms;

  RainbowSettings(int update_rate_ms) {
    this.update_rate_ms = update_rate_ms;
  }

  public byte[] getMessage()
  {
    byte data[] = new byte[5];
    data[0] = LightInterfaceMessage.RAINBOW.getValue();
    Serializer.serializeIntLE(this.update_rate_ms, data, 1);
    return data;
  }
}