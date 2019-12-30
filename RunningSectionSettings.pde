class RunningSectionSettings {
  int pulse_time_ms;
  int section_count;
  int section_size;
  
  RunningSectionSettings(int pulse_time_ms, int section_count, int section_size) {
    this.pulse_time_ms = pulse_time_ms;
    this.section_count = section_count;
    this.section_size = section_size;
  }

  public byte[] getMessage()
  {
    byte data[] = new byte[13];
    data[0] = LightInterfaceMessage.RUNNING_SECTIONS.getValue();
    Serializer.serializeIntLE(this.pulse_time_ms, data, 1);
    Serializer.serializeIntLE(this.section_count, data, 5);
    Serializer.serializeIntLE(this.section_size, data, 9);
    return data;
  }
}