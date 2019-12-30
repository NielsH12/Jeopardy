enum LightMode {
  OFF(0),
  ON(1),
  STROBE(2),
  GLITTER(3),
  FREQUENCY(4),
  TETRIS(5),
  GAME_OF_LIFE(6),
  RUNNING_RING(7),
  PULSE(8),
  RUNNING_SECTIONS(9),
  RAINBOW(10);

  private final int value;

  private LightMode(int value) {
    this.value = value;
  }

  public byte getValue()
  {
    return (byte)this.value;
  }
}