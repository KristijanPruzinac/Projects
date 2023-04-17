#include <framework.h>

using namespace std;

int imageModeX = LEFT;
int imageModeY = CENTER;

//Timers
auto start1 = std::chrono::system_clock::now();
auto stop1 = std::chrono::system_clock::now();
auto start2 = std::chrono::system_clock::now();
auto stop2 = std::chrono::system_clock::now();
auto start3 = std::chrono::system_clock::now();
auto stop3 = std::chrono::system_clock::now();
auto start4 = std::chrono::system_clock::now();
auto stop4 = std::chrono::system_clock::now();
auto start5 = std::chrono::system_clock::now();
auto stop5 = std::chrono::system_clock::now();

int leftover_time = 0;

void t_start(int i){
    if (i == 1)
        start1 = std::chrono::system_clock::now();
    else if (i == 2)
        start2 = std::chrono::system_clock::now();
    else if (i == 3)
        start3 = std::chrono::system_clock::now();
    else if (i == 4)
        start4 = std::chrono::system_clock::now();
    else if (i == 5)
        start5 = std::chrono::system_clock::now();
}

void t_stop(int i){
    if (i == 1)
        stop1 = std::chrono::system_clock::now();
    else if (i == 2)
        stop2 = std::chrono::system_clock::now();
    else if (i == 3)
        stop3 = std::chrono::system_clock::now();
    else if (i == 4)
        stop4 = std::chrono::system_clock::now();
    else if (i == 5)
        stop5 = std::chrono::system_clock::now();
}

void t_print_millis(int i){
    if (i == 1){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop1 - start1); cout << "Took " << duration.count() << " milliseconds." << endl; }
    else if (i == 2){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop2 - start2); cout << "Took " << duration.count() << " milliseconds." << endl; }
    else if (i == 3){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop3 - start3); cout << "Took " << duration.count() << " milliseconds." << endl; }
    else if (i == 4){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop4 - start4); cout << "Took " << duration.count() << " milliseconds." << endl; }
    else if (i == 5){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop5 - start5); cout << "Took " << duration.count() << " milliseconds." << endl; }
}

void t_print_micros(int i){
    if (i == 1){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop1 - start1); cout << "Took " << duration.count() << " microseconds." << endl; }
    else if (i == 2){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop2 - start2); cout << "Took " << duration.count() << " microseconds." << endl; }
    else if (i == 3){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop3 - start3); cout << "Took " << duration.count() << " microseconds." << endl; }
    else if (i == 4){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop4 - start4); cout << "Took " << duration.count() << " microseconds." << endl; }
    else if (i == 5){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop5 - start5); cout << "Took " << duration.count() << " microseconds." << endl; }
}

long long int t_millis(int i){
    if (i == 1){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop1 - start1); return (long long int)(duration.count()); }
    else if (i == 2){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop2 - start2); return (long long int)(duration.count()); }
    else if (i == 3){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop3 - start3); return (long long int)(duration.count()); }
    else if (i == 4){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop4 - start4); return (long long int)(duration.count()); }
    else if (i == 5){
        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(stop5 - start5); return (long long int)(duration.count()); }
    return -1;
}

long long int t_micros(int i){
    if (i == 1){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop1 - start1); return (long long int)(duration.count()); }
    else if (i == 2){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop2 - start2); return (long long int)(duration.count()); }
    else if (i == 3){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop3 - start3); return (long long int)(duration.count()); }
    else if (i == 4){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop4 - start4); return (long long int)(duration.count()); }
    else if (i == 5){
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop5 - start5); return (long long int)(duration.count()); }
    return -1;
}

//Screen resolution
int screen_width = GetSystemMetrics(SM_CXSCREEN);
int screen_height = GetSystemMetrics(SM_CYSCREEN);

//Window settings
int frameRate = 60;
long long int frameCount = 0;
int width = 640;
int height = 480;
string title = "Window";

//Mouse
int mouse_x = 0;
int mouse_y = 0;

//Keyboard
bool keys[128];
bool keys_t[128];

//Font texture count
int texture_count = 89;
int special_chars_count = 27;

//Special characters
char special_chars[27] = {' ','.',',',':',';','+','-','*','/','_','!','?','(',')','[',']','{','}','<','>','=','"','#','$','%','&','\\'};

//Framework functionality
void passiveMouseFunc(int mx, int my){
    mouse_x = mx;
    mouse_y = my;
}

void updateFrame(){
    t_start(1);
    for (int i = 0; i < 128; i++){
        if (keys[i] != keys_t[i]){
            keys[i] = keys_t[i];

            if (keys_t[i] == 1)
                keyPressed(i);
            else
                keyReleased(i);
        }
    }
    glClear(GL_COLOR_BUFFER_BIT);

    //Update guis
    for (int i = 0; i < guis_num; i++)
        guis[i] -> updatePassive(mouse_x, mouse_y);

    draw();
    glutSwapBuffers();

    t_stop(1);
    long long int t_taken = t_micros(1);
    while (t_taken <= 1000000 / frameRate){
        Sleep(1);
        t_stop(1);
        t_taken = t_micros(1) + leftover_time;
    }
    leftover_time = t_taken - 1000000 / frameRate;

    frameCount++;
}

void reshapeFunc(int w, int h){
    width = w;
    height = h;

    glViewport(0, 0, width, height);
    glLoadIdentity();
    glOrtho(0.f, width, height, 0.f, 0.f, 1.f);
}

void kp(unsigned char key, int x, int y){
    keys_t[key] = 1;
}

void kr(unsigned char key, int x, int y){
    keys_t[key] = 0;
}

void mouse_pre(int button_, int state_, int mx_, int my_){
    //Update guis
    for (int i = 0; i < guis_num; i++)
        guis[i] -> updateAction(1 - state_, button_, mx_, my_);

    mouse(button_, 1 - state_, mx_, my_);
}

int main(int argc, char *argv[])
{
	settings();
    glutInit(&argc, argv);
    glutInitWindowSize(width, height);
    glutInitWindowPosition(10, 10);
    glutInitDisplayMode(GLUT_RGB);

    glutCreateWindow(&title[0]);

    //Init
    glClearColor(1.0, 1.0, 1.0, 0.0);
    glLoadIdentity();
    glOrtho(0.f, width, height, 0.f, 0.f, 1.f);

    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);

    //Functions
    setup();
    glutDisplayFunc(updateFrame);
    glutIdleFunc(updateFrame);
    glutPassiveMotionFunc(passiveMouseFunc);
    glutMouseFunc(mouse_pre);
    glutReshapeFunc(reshapeFunc);
    glutMotionFunc(passiveMouseFunc);
    glutKeyboardFunc(kp);
    glutKeyboardUpFunc(kr);
    glutCloseFunc(close);

    for (int i = 0; i < 128; i++)
        keys[i] = false;

    //Loop
    glutMainLoop();

    return EXIT_SUCCESS;
}

//Helpful functions
bool isIn(string sub, string original, bool recognizeUpper = false){
    int len = sub.length();

    bool is = true;
    if (recognizeUpper){
        for (int i = 0; i < len; i++){
            if (original[i] != sub[i]){
                is = false;
                break;
            }
        }
    }
    else {
        for (int i = 0; i < len; i++){
            if (tolower(original[i]) != tolower(sub[i])){
                is = false;
                break;
            }
        }
    }

    return is;
}

//Image class
bool Image::read(string filename){
    unsigned int offset;
    int padding;

    //Open image file
    ifstream file;
    file.open(filename, std::ios::binary);

    //Fail
    if (file.fail()) {
        file.close();
        return 0;
    }

    string empty_ = "..........................";

    //Data offset
    file.read(&empty_[0], 10);
    file.read((char*)&offset, 4);

    //Width and height
    file.read(&empty_[0], 4);
    file.read((char*)&w, 4);
    file.read((char*)&h, 4);

    //Bits per pixel
    file.read(&empty_[0], 2);
    file.read((char*)&bpp, 2);
    bpp /= 8;

    //Calculate row padding
    padding = (4 - ((w * bpp) % 4)) % 4;

    //Go to start of data
    file.seekg(file.beg + offset);

    arr = new unsigned char[w*h*bpp * 2];

    //Read
    for (int r = h - 1; r > -1; r--){
        file.read((char*)&arr[r * w*bpp], w*bpp);
        file.read(&empty_[0], padding);
        //file.seekg(file.tellg() + padding);
    }

    file.close();

    initTexture();

    return 1;
}

void Image::write(string filename){
    int padding;

    //Open image file
    ofstream file;
    file.open(filename, std::ios::binary);

    //Fail
    if (file.fail()) {
        file.close();
        cout << "Cant open file!" << endl;
    }

    //Calculate row padding
    padding = (4 - ((w * bpp) % 4)) % 4;

    //Header ---------------------------

    //Signature
    file.write("BM", 2);

    //File size
    unsigned int file_size = h * (w * bpp + padding) + 54;
    file.write((char*) &file_size, 4);

    //Reserved
    unsigned short tmp_s = 0;
    file.write((char*) &tmp_s, 2);
    file.write((char*) &tmp_s, 2);

    //Data offset
    unsigned int offset = 54;
    file.write((char*) &offset, 4);

    //Size of header
    unsigned int tmp = 40;
    file.write((char*) &tmp, 4);

    //Width and height
    signed int w_s = w;
    signed int h_s = h;

    file.write((char*) &w_s, 4);
    file.write((char*) &h_s, 4);

    //Planes
    tmp_s = 1;
    file.write((char*) &tmp_s, 2);

    //Bits per pixel
    unsigned short bpp_fxed = bpp * 8;
    file.write((char*) &bpp_fxed, 2);

    //Compression
    tmp = 0;
    file.write((char*) &tmp, 4);

    file.write((char*) &tmp, 4);
    file.write((char*) &tmp, 4);
    file.write((char*) &tmp, 4);
    file.write((char*) &tmp, 4);
    file.write((char*) &tmp, 4);

    string padded = "";
    for (int i = 0; i < padding; i++){
        padded += ' ';
    }

    //Write
    for (int r = h - 1; r > -1; r--){
        file.write((char*)&arr[r * w*bpp], w*bpp);
        file.write((char*) &padded, padding);
    }

    file.close();
    return;
}

void Image::setSize(unsigned int w, unsigned int h){
    this -> w = w;
    this -> h = h;
}

void Image::place(Image* from_image, unsigned int x, unsigned int y){
    unsigned int from_w = from_image -> w;
    unsigned int from_h = from_image -> h;
    unsigned short from_bpp = from_image -> bpp;
    unsigned char* from_arr = &(from_image -> arr[0]);

    unsigned int t_h = from_h;
    unsigned int t_w = from_w;

    if (y + t_h > h)
        t_h = h - y - 1;
    if (x + t_w > w)
        t_w = w - x - 1;

    for (unsigned int r = 0; r < t_h; r++){
        if (y + r >= h){
            break;
        }

        for (unsigned int s = 0; s < t_w; s++){
            if (x + s >= w){
                break;
            }

            for (int c = 0; c < from_bpp; c++){
                arr[(y + r) * w * from_bpp + (x + s) * from_bpp + c] = from_arr[r * from_w * from_bpp + s * from_bpp + c];
            }
        }
    }
}

void Image::copyFrom(Image* from_image, unsigned int x_, unsigned int y_, unsigned int w_, unsigned int h_, unsigned int off_x = 0, unsigned int off_y = 0){
    unsigned int max_y = y_ + h_;
    unsigned int max_x = x_ + w_;

    unsigned int from_w = from_image -> w;
    unsigned int from_h = from_image -> h;
    unsigned int from_bpp = from_image -> bpp;
    unsigned char* from_arr = &(from_image -> arr[0]);

    if (max_y > from_h)
        max_y = from_h;
    if (max_x > from_w)
        max_x = from_w;

    setSize(max_x - x_ + off_x, max_y - y_ + off_y);
    bpp = from_bpp;

    for (unsigned int r = y_; r < max_y; r++){
        for (unsigned int s = x_; s < max_x; s++){
            for (unsigned int i = 0; i < from_bpp; i++)
                arr[((r - y_) + off_y) * w * from_bpp + ((s - x_) + off_x) * from_bpp + i] = from_arr[r * from_w * from_bpp + s * from_bpp + i];
        }
    }
}

void Image::initTexture(){
    if (first_read){
        first_read = false;

        glGenTextures(1, &texture);
    }

    glBindTexture(GL_TEXTURE_2D, texture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

    if (bpp == 4)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, &arr[0]);
    else if (bpp == 3)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, w, h, 0, GL_RGB, GL_UNSIGNED_BYTE, &arr[0]);
    else if (bpp == 2)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE_ALPHA, w, h, 0, GL_LUMINANCE_ALPHA, GL_UNSIGNED_BYTE, &arr[0]);
    else if (bpp == 1)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, w, h, 0, GL_LUMINANCE, GL_UNSIGNED_BYTE, &arr[0]);

    glBindTexture(GL_TEXTURE_2D, 0);
}

void Image::draw(int x_, int y_, int w_, int h_, int mode = CORNER){
    glBindTexture(GL_TEXTURE_2D, texture);
    glEnable(GL_TEXTURE_2D);
    glBegin(GL_QUADS);

    switch (mode){
        case CORNER:
            glTexCoord2i(0, 0); glVertex2i(x_, y_);
            glTexCoord2i(0, 1); glVertex2i(x_, y_ + h_);
            glTexCoord2i(1, 1); glVertex2i(x_ + w_, y_ + h_);
            glTexCoord2i(1, 0); glVertex2i(x_ + w_, y_);
        break;

        case CORNERS:
            glTexCoord2i(0, 0); glVertex2i(x_, y_);
            glTexCoord2i(0, 1); glVertex2i(x_, h_);
            glTexCoord2i(1, 1); glVertex2i(w_, h_);
            glTexCoord2i(1, 0); glVertex2i(w_, y_);
        break;

        case CENTER:
            glTexCoord2i(0, 0); glVertex2i(x_ - (int) (w_ / 2), y_ - (int) (h_ / 2));
            glTexCoord2i(0, 1); glVertex2i(x_ - (int) (w_ / 2), y_ + (int) (h_ / 2));
            glTexCoord2i(1, 1); glVertex2i(x_ + (int) (w_ / 2), y_ + (int) (h_ / 2));
            glTexCoord2i(1, 0); glVertex2i(x_ + (int) (w_ / 2), y_ - (int) (h_ / 2));
        break;
    }

    glEnd();
    glDisable(GL_TEXTURE_2D);
    glBindTexture(GL_TEXTURE_2D, 0);
}

Image::~Image(){
    delete[] arr;
}

Image fontImage;
Image fontTmpImage;
void createFontFromImage(string font_name){
    fontImage.read("Fonts/" + font_name + "/" + font_name + ".bmp");

    int index = 0;

    int indexes[texture_count * 2];

    int arr_index = 0;

    while (true){
        if (arr_index == texture_count * 2)
            break;

        if (fontImage.arr[index*fontImage.bpp] == 0){
            indexes[arr_index] = index;
            arr_index++;
        }
        index++;
    }

    string dir = "Fonts/" + font_name + "/textures";
    mkdir(&dir[0]);

    for (int i = 0; i < texture_count; i++){
        fontTmpImage.copyFrom(&fontImage, indexes[i * 2], 1, indexes[i * 2 + 1] - indexes[i * 2] + 1, fontImage.h - 1);
        for (unsigned int c = 0; c < fontTmpImage.w*fontTmpImage.h; c++){
            fontTmpImage.arr[c * 4 + 3] = 255 - fontTmpImage.arr[c * 4];
            fontTmpImage.arr[c * 4] = 0;
            fontTmpImage.arr[c * 4 + 1] = 0;
            fontTmpImage.arr[c * 4 + 2] = 0;
        }
        fontTmpImage.write("Fonts/" + font_name + "/textures/" + to_string(i) + ".bmp");
    }
}

Font::Font(string font_name, int font_size){
    initialized = false;

    this -> font_name = font_name;
    this -> font_size = font_size;

    scaling_factor = font_size / 200.0;

    for (int i = 0; i < texture_count; i++){
        if (!textures[i].read("Fonts/" + font_name + "/textures/" + to_string(i) + ".bmp")){
            cout << "Failed to initialize " << font_name << " font... Cant access textures.";
            exit(0);
        }

        widths[i] = (int) (textures[i].w * scaling_factor);
    }

    font_height = (int) (textures[0].h * scaling_factor);

    font_spacing = (int) (16 * (font_size / 200.0));

    int px_num = ceil(200.0 / font_size);
    if (px_num % 2 == 0){
        px_num++;
    }
    for (int i = 0; i < texture_count; i++){
        for (int c = 0; c < ceil(200.0 / font_size) - 1; c++){
            for (int r = 1; r < textures[i].h - 1; r++){
                for (int s = 1; s < textures[i].w - 1; s++){
                    int val = 0;
                    for (int off_y = r - 1; off_y <= r + 1; off_y++){
                        for (int off_x = s - 1; off_x <= s + 1; off_x++){
                            val += textures[i].arr[off_y * textures[i].w * 4 + off_x * 4 + 3];
                        }
                    }
                    textures[i].arr[r * textures[i].w * 4 + s * 4 + 3] = (int) (val / 9.0);
                }
            }
        }
    }

    for (int i = 0; i < texture_count; i++){
        for (int index = 0; index < textures[i].w*textures[i].h; index++){
            textures[i].arr[index * 4] = 255;
            textures[i].arr[index * 4 + 1] = 255;
            textures[i].arr[index * 4 + 2] = 255;
        }
    }

    r = 0;
    g = 0;
    b = 0;
    alpha = 255;
}

void Font::initTextures(){
    for (int i = 0; i < texture_count; i++){
        textures[i].first_read = true;
        textures[i].initTexture();
    }
    initialized = true;
}

void Font::setColor(unsigned char r, unsigned char g, unsigned char b){
    this -> r = r;
    this -> g = g;
    this -> b = b;
    this -> alpha = 255;
}

void Font::setColor(unsigned char r, unsigned char g, unsigned char b, unsigned char alpha){
    this -> r = r;
    this -> g = g;
    this -> b = b;
    this -> alpha = alpha;
}

int textureIndex(char chr){
    if (chr >= 'A' && chr <= 'Z'){
        return chr - 'A';
    }
    else if (chr >= 'a' && chr <= 'z'){
        return chr - 'a' + 26;
    }
    else if (chr >= '0' && chr <= '9'){
        return chr - '0' + 52;
    }
    else {
        for (int i = 0; i < special_chars_count; i++){
            if (chr == special_chars[i]){
                return i + 62;
            }
        }

        return -1;
    }
}

int textHeight(Font* fontptr){
    return (*fontptr).font_height;
}

int textWidth(string str, Font* fontptr){
    int len = str.length();
    int t_width = 0;

    for (int i = 0; i < len; i++){
        int texture_index = textureIndex(str[i]);

        if (texture_index == -1)
            continue;

        t_width += fontptr -> widths[texture_index];
    }

    return t_width;
}

void text(string str, int x, int y, Font* fontptr){
    if (!(fontptr -> initialized)){
        fontptr -> initTextures();
    }

    int len = str.length();
    int t_width = textWidth(str, fontptr);

    int x_off = 0;
    int y_off = 0;

    switch (imageModeX){
    /*case LEFT:
        x_off = 0;
    break;*/

    case CENTER:
        x_off = -(int) (t_width / 2.0);
    break;

    case RIGHT:
        x_off = -t_width;
    break;
    }

    switch (imageModeY){
    /*case TOP:
        y_off = 0;
    break;*/

    case CENTER:
        y_off = -(int) (fontptr -> font_height / 2.0);
    break;

    case BOTTOM:
        y_off = -(fontptr -> font_height);
    break;
    }

    int x_current = x + x_off;
    int y_current = y + y_off;

    glColor4f(fontptr -> r / 255.0, fontptr -> g / 255.0, fontptr -> b / 255.0, fontptr -> alpha / 255.0);
    for (int i = 0; i < len; i++){
        int texture_index = textureIndex(str[i]);

        if (texture_index == -1)
            continue;

        fontptr -> textures[texture_index].draw(x_current, y_current, fontptr -> widths[texture_index], fontptr -> font_height, CORNER);
        x_current += fontptr -> widths[texture_index] + fontptr -> font_spacing;
    }
}

void text(string str, int x, int y, int w, Font* fontptr){
    if (!(fontptr -> initialized)){
        fontptr -> initTextures();
    }

    int len = str.length();
    int t_width = textWidth(str, fontptr);

    int x_off = 0;
    int y_off = 0;

    switch (imageModeX){
    /*case LEFT:
        x_off = 0;
    break;*/

    case CENTER:
        x_off = -(int) (t_width / 2.0);
    break;

    case RIGHT:
        x_off = -t_width;
    break;
    }

    switch (imageModeY){
    /*case TOP:
        y_off = 0;
    break;*/

    case CENTER:
        y_off = -(int) (fontptr -> font_height / 2.0);
    break;

    case BOTTOM:
        y_off = -(fontptr -> font_height);
    break;
    }

    int x_current = x + x_off;
    int y_current = y + y_off;

    glColor4f(fontptr -> r / 255.0, fontptr -> g / 255.0, fontptr -> b / 255.0, fontptr -> alpha / 255.0);

    if (imageModeX == CENTER){
        int index = 0;
        while (true){
            if (index >= len - 1)
                break;

            int c_x = x_current;
            int c_y = y_current;
            int n_index;
            int i;
            for (i = index; i < len; i++){
                int texture_index = textureIndex(str[i]);

                if (texture_index == -1)
                    continue;

                if (x_current - (x + x_off) + fontptr -> widths[texture_index] > w){
                    break;
                    y_current += fontptr -> font_height;
                    x_current = (x + x_off);
                }

                x_current += fontptr -> widths[texture_index] + fontptr -> font_spacing;
            }

            x_current = c_x - (x_current - c_x) / 2;
            y_current = c_y;
            n_index = i;

            if (n_index - index == 0)
                break;

            for (i = index; i < n_index; i++){
                int texture_index = textureIndex(str[i]);

                if (texture_index == -1)
                    continue;

                fontptr -> textures[texture_index].draw(x_current, y_current, fontptr -> widths[texture_index], fontptr -> font_height, CORNER);
                x_current += fontptr -> widths[texture_index] + fontptr -> font_spacing;
            }

            x_current = x + x_off;
            y_current += fontptr -> font_height;

            index = n_index;
        }
    }
    else {
        for (int i = 0; i < len; i++){
            int texture_index = textureIndex(str[i]);

            if (texture_index == -1)
                continue;

            if (x_current - (x + x_off) + fontptr -> widths[texture_index] > w){
                y_current += fontptr -> font_height;
                x_current = (x + x_off);
            }

            fontptr -> textures[texture_index].draw(x_current, y_current, fontptr -> widths[texture_index], fontptr -> font_height, CORNER);
            x_current += fontptr -> widths[texture_index] + fontptr -> font_spacing;
        }
    }
}

void textMode(int x, int y){
    imageModeX = x;
    imageModeY = y;
}

bool isMouseOn(int mx_, int my_, int x_, int y_, int w_, int h_){
    if (mx_ >= x_ && mx_ <= x_ + w_ && my_ >= y_ && my_ <= y_ + h_)
        return true;
    else
        return false;
}

Button::Button(){}

void Button::init(int x, int y, int w, int h){
    this -> x = x;
    this -> y = y;
    this -> w = w;
    this -> h = h;

    this -> rotation = 0;
    this -> rotated = false;

    this -> hasImage = false;
}

void Button::init(int x_, int y_, int w_, int h_, string filename_){
    this -> x = x_;
    this -> y = y_;

    this -> image.read(filename_);
    if (w_ == -1){
        this -> w = this -> image.w;
        this -> h = this -> image.h;
    }
    else {
        this -> w = w_;
        this -> h = h_;
    }

    this -> rotation = 0;
    this -> rotated = false;

    this -> hasImage = true;
}

void Button::init(int x, int y, int w, int h, float rotation_){
    this -> x = x;
    this -> y = y;
    this -> w = w;
    this -> h = h;

    this -> rotation = rotation_;
    if (rotation_ != 0)
        this -> rotated = true;
    else
        this -> rotated = false;

    this -> hasImage = false;
}

void Button::init(int x_, int y_, int w_, int h_, float rotation_, string filename_){
    this -> x = x_;
    this -> y = y_;

    this -> image.read(filename_);
    if (w_ == -1){
        this -> w = this -> image.w;
        this -> h = this -> image.h;
    }
    else {
        this -> w = w_;
        this -> h = h_;
    }

    this -> rotation = rotation_;
    if (rotation_ != 0)
        this -> rotated = true;
    else
        this -> rotated = false;

    this -> image.read(filename_);

    this -> hasImage = true;
}

void Button::setTexture(string filename_){
    this -> image.read(filename_);
    this -> hasImage = true;
}

void Button::draw(){
    if (!hasImage)
        return;
    if (!rotated)
        this -> image.draw(this -> x, this -> y, this -> w, this -> h, CORNER);
    else {
        glPushMatrix();
        glTranslated(this -> x + (int)(this -> w / 2.0), this -> y + (int)(this -> h / 2.0), 0);
        glRotatef(this -> rotation, 0, 0, 1);
        image.draw(0, 0, this -> w, this -> h, CENTER);
        glPopMatrix();
    }
}

void Button::rotate(float rotation_){
    if (rotation_ != 0){
        this -> rotation = rotation_;
        this -> rotated = true;
    }
    else {
        this -> rotation = rotation_;
        this -> rotated = false;
    }
}

void Button::setPos(int x_, int y_){
    this -> x = x_;
    this -> y = y_;
}

void Button::setSize(int w_, int h_){
    this -> w = w_;
    this -> h = h_;
}

void Button::registerPassiveCallback(void (*fcnptr_)(Button*, bool)){
    this -> passive_callback = fcnptr_;
    this -> registered_passive = true;
}

void Button::registerActionCallback(void (*fcnptr_)(Button*, bool, bool)){
    this -> action_callback = fcnptr_;
    this -> registered_action = true;
}

void Button::updatePassive(int mx_, int my_){
    bool val = isMouseOn(mx_, my_, this -> x, this -> y, this -> w, this -> h);

    if (!val)
        this -> hovered = false;
    else
        this -> hovered = true;

    if (this -> registered_passive)
        this -> passive_callback(this, val);
}

void Button::updateAction(bool click_type_, bool mouse_button_, int mx_, int my_){
    if (this -> registered_action){
        if (isMouseOn(mx_, my_, this -> x, this -> y, this -> w, this -> h)){
            action_callback(this, click_type_, mouse_button_);

            if (!mouse_button_)
                if (!click_type_)
                    this -> pressed_left = false;
                else
                    this -> pressed_left = true;
            else
                if (!click_type_)
                    this -> pressed_right = false;
                else
                    this -> pressed_right = true;
        }
        else {
            if (!click_type_){
                this -> pressed_left = false;
                this -> pressed_right = false;
            }
        }
    }
}

vector<GUI*> guis;
int guis_num = 0;

GUI::GUI(){
    this -> buttons_num = 0;
}

void GUI::addButton(Button button_, string name_){
    this -> button_indexes.push_back(name_);
    this -> buttons.push_back(button_);
    this -> buttons_num++;
}

bool GUI::removeButton(string name_){
    int index_ = -1;
    for (int i = 0; i < buttons_num; i++){
        if (button_indexes[i] == name_){
            index_ = i;
            break;
        }
    }

    if (index_ != -1){
        buttons.erase(buttons.begin() + index_);
        button_indexes.erase(button_indexes.begin() + index_);
        buttons_num--;
        return true;
    }
    else {
        return false;
    }
}

Button* GUI::getButton(string name_){
    int index_ = -1;
    for (int i = 0; i < buttons_num; i++){
        if (button_indexes[i] == name_){
            index_ = i;
            break;
        }
    }

    if (index_ == -1)
        return NULL;

    return &buttons[index_];
}

void GUI::updatePassive(int mx_, int my_){
    for (int i = 0; i < buttons_num; i++)
        buttons[i].updatePassive(mx_, my_);
}

void GUI::updateAction(bool click_type_, bool mouse_button_, int mx_, int my_){
    for (int i = 0; i < buttons_num; i++)
        buttons[i].updateAction(click_type_, mouse_button_, mx_, my_);
}

void GUI::draw(){
    for (int i = 0; i < buttons_num; i++)
        buttons[i].draw();
}

void registerGui(GUI* guiptr){
    guis.push_back(guiptr);
    guis_num++;
}

Animation::Animation(){
    len = 0;
    t_start(2);
}

int Animation::addAnimation(string name, int duration, int type){
    bool is = false;
    for (int i = 0; i < len; i++){
        if (names[i] == name){
            is = true;
            break;
        }
    }

    if (is){
        return 0;
    }

    names.push_back(name);
    duration_lefts.push_back(duration);
    durations.push_back(duration);
    types.push_back(type);

    len++;
    return 1;
}

int Animation::removeAnimation(string name){
    for (int i = 0; i < len; i++){
        if (names[i] == name){
            names.erase(names.begin() + i, names.begin() + i + 1);
            duration_lefts.erase(duration_lefts.begin() + i, duration_lefts.begin() + i + 1);
            durations.erase(durations.begin() + i, durations.begin() + i + 1);
            types.erase(types.begin() + i, types.begin() + i + 1);

            len--;
            break;
        }
    }
}

void Animation::update(){
    t_stop(2);
    int time_elapsed = t_millis(2);
    t_start(2);

    for (int i = 0; i < len; i++){
        if (duration_lefts[i] != 0)
            duration_lefts[i] -= time_elapsed;

        if (duration_lefts[i] < 0){
            duration_lefts[i] = 0;
        }
    }
}

float Animation::getValue(string name){
    for (int i = 0; i < len; i++){
        if (names[i] == name){
            switch (types[i]){
            case LINEAR:
                return 1 - float(duration_lefts[i]) / durations[i];
            break;

            case EASE_IN:
                return 1 - cos(((1 - float(duration_lefts[i]) / durations[i]) / 2) * PI);
            break;

            case EASE_OUT:
                return cos((float(duration_lefts[i]) / durations[i]) * PI / 2.0);
            break;
            }
            break;
        }
    }
}

bool Animation::isFinished(string name){
    for (int i = 0; i < len; i++){
        if (names[i] == name)
            if (duration_lefts[i] == 0)
                return true;
            else
                return false;
    }
}
