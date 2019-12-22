class ColorSettings {
     byte r;
     byte g;
     byte b;
     
     /*Set the rgb colors. Range: 0-1*/
     ColorSettings(float _r, float _g, float _b)
     {
       this.r = (byte)(_r * 255);
       this.g = (byte)(_g * 255);
       this.b = (byte)(_b * 255);
     }
}