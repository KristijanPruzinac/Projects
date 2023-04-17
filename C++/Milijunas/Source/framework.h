#include <GL/freeglut.h>
#include <chrono>
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <vector>
#include <map>
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

//Animation class
#define LINEAR 0
#define EASE_IN 1
#define EASE_OUT 2

#define PI 3.1415

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

extern int leftover_time;

//Framework functionality
void uf_a();
void uf_na();
void passiveMouseFunc(int, int);
void updateFrame(bool);
void reshapeFunc(int, int);
void kp(unsigned char, int, int);
void kr(unsigned char, int, int);
void mouse_pre(int, int, int, int);
void mouse(int, int, int, int);
void close();
void keyPressed(unsigned char);
void keyReleased(unsigned char);
void settings();
void setup();
void draw();

//Test
void createFontFromImage(std::string);

//Helpful functions
bool isIn(std::string, std::string, bool);

bool isMouseOn(int, int, int, int, int, int);

//Image class
class Image{
public:
    unsigned int w;
    unsigned int h;
    unsigned short bpp;

    unsigned char* arr; //Change when working with large images

    GLuint texture;

    bool first_read = true;

    bool read(std::string);
    void write(std::string);
    void setSize(unsigned int, unsigned int);
    void place(Image*, unsigned int, unsigned int);
    void copyFrom(Image*, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
    void initTexture();
    void draw(int, int, int, int, int);
    ~Image();
};

//Create Fonts from Font image
void createFontFromImage(std::string);

//Font class
class Font{
public:
    int widths[89];
    Image textures[89];

    unsigned char r;
    unsigned char g;
    unsigned char b;
    unsigned char alpha;

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
    void setColor(unsigned char, unsigned char, unsigned char, unsigned char);
};

int textureIndex(char);
int textHeight(Font*);
int textWidth(std::string, Font*);
void text(std::string, int, int, Font*);
void text(std::string, int, int, int, Font*);
void textMode(int, int);

class Button{
public:
    Image image;
    int x;
    int y;
    int w;
    int h;

    float rotation;
    bool rotated;

    bool hovered;
    bool pressed_left;
    bool pressed_right;

    bool registered_passive;
    bool registered_action;

    bool hasImage;

    void (*passive_callback)(Button*, bool);
    void (*action_callback)(Button*, bool, bool); //Press or Release, Click type

    Button();
    void init(int, int, int, int);
    void init(int, int, int, int, float);
    void init(int, int, int, int, std::string);
    void init(int, int, int, int, float, std::string);
    void setTexture(std::string);
    void updatePassive(int, int);
    void updateAction(bool, bool, int, int);
    void draw();
    void rotate(float);
    void setPos(int, int);
    void setSize(int, int);
    void registerPassiveCallback(void (*)(Button*, bool));
    void registerActionCallback(void (*)(Button*, bool, bool));
};

class GUI{
public:
    int buttons_num;
    std::vector<Button> buttons;
    std::vector<std::string> button_indexes;

    GUI();
    void addButton(Button, std::string);
    bool removeButton(std::string);
    Button* getButton(std::string);
    void init();
    void updatePassive(int, int);
    void updateAction(bool, bool, int, int);
    void draw();
};

extern std::vector<GUI*> guis;
extern int guis_num;

void registerGui(GUI*);

class Animation {
public:
    int len;
    std::vector<std::string> names;
    std::vector<int> duration_lefts;
    std::vector<int> durations;
    std::vector<char> types;

    Animation();
    int addAnimation(std::string, int, int);
    int removeAnimation(std::string);
    bool isFinished(std::string);
    float getValue(std::string);
    void update();
};
