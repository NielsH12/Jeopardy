enum LightInterfaceMessage {
    LIGHT_MODE(0),
    STROBE(1),
    GLITTER(2),
    NODE_INFO(3),
    FREQUENCY_INFO(4),
    SAMPLES(5),
    TETRIS_MOVE(6),
    WIFI_SETTINGS(7),
    SCAN_WIFI(8),
    OTA_DATA(9),
    PING(10),
    PULSE_SETTINGS(11),
    ONBOARD_LED_STRENGTH(12);

  private final int value;

  private LightInterfaceMessage(int value) {
    this.value = value;
  }

  public byte getValue()
  {
    return (byte)this.value;
  }
}
