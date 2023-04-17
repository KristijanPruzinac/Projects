#include <GL/freeglut.h>
#include <chrono>
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <vector>
#include <cstring>
#include <cmath>

#include <conio.h>
#include <io.h>
#include <process.h>
#include <stdio.h>

//Internal values
#define CORNER 0
#define CORNERS 2

#define LEFT 0
#define CENTER 1
#define RIGHT 2
#define TOP 0
#define BOTTOM 2

//Screen resolution
extern int screen_width;
extern int screen_height;

//Window settings
extern int frameRate;
extern long long int frameCount;
extern int width;
extern int height;
extern std::string title;

//Mouse
extern int mouse_x;
extern int mouse_y;

//Keyboard
extern bool keys[128];
extern bool keys_t[128];

//Image modes
extern int imageModeX;
extern int imageModeY;

//Font texture count
extern int texture_count;
extern int special_chars_count;

//Font special characters
extern char special_chars[27];

//Timers
void t_start(int);
void t_stop(int);
void t_print_millis(int);
void t_print_micros(int);
long long int t_millis(int);
long long int t_micros(int);

//Framework functionality
void uf_a();
void uf_na();
void passiveMouseFunc(int, int);
void updateFrame(bool);
void reshapeFunc(int, int);
void kp(unsigned char, int, int);
void kr(unsigned char, int, int);
void mouse(int, int, int, int);
void keyPressed(unsigned char);
void keyReleased(unsigned char);
void settings();
void setup();
void draw(bool);

//Test
void createFontFromImage(std::string);

//Helpful functions
bool isIn(std::string, std::string, bool);

//Image class
class Image{
public:
    unsigned int w;
    unsigned int h;
    unsigned short bpp;

    unsigned char arr[1920*1080*4]; //Change when working with large images
    unsigned char arr2[1920*1080*4];

    GLuint texture;

    bool first_read;

    bool read(std::string);
    void write(std::string);
    void setSize(unsigned int, unsigned int);
    void place(Image*, unsigned int, unsigned int);
    void copyFrom(Image*, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
    void initTexture();
    void draw(int, int, int, int, int);
};

//Create Fonts from Font image
void createFontFromImage(std::string);

//Font class
class Font{
public:
    int widths[89];
    Image textures[89];

    std::string font_name;
    int font_size;

    bool initialized;

    float scaling_factor;
    int font_height;

    int font_spacing;

    bool antialiased;

    Font(std::string, int);
    void initTextures();
    void setColor(unsigned char, unsigned char, unsigned char);
};

int textureIndex(char);
int textHeight(Font*);
int textWidth(std::string, Font*);
void text(std::string, int, int, Font*);
void text(std::string, int, int, int, Font*);
void textMode(int, int);
