static class Serializer {
    public static void serializeFloatLE(float value, byte[] data, int offset) {
        int intBits =  Float.floatToIntBits(value);
        data[offset + 0] = (byte) (intBits);
        data[offset + 1] = (byte) (intBits >> 8);
        data[offset + 2] = (byte) (intBits >> 16);
        data[offset + 3] = (byte) (intBits >> 24);
    }
    public static void serializeIntLE(int value, byte[] data, int offset) {
        data[offset + 0] = (byte) (value);
        data[offset + 1] = (byte) (value >> 8);
        data[offset + 2] = (byte) (value >> 16);
        data[offset + 3] = (byte) (value >> 24);
    }
}