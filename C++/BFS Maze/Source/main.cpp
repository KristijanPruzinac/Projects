#include <iostream>
#include <framework.h>

#include <iostream>
#include <cmath>
#include <cstring>
#include <fstream>

using namespace std;

struct st{
    int y;
    int x;

    int o_index;
};

int start_x;
int start_y;

int r;
int s;

int tile_size = 30;

char polje[100][100];

const int max_len = 10000;
st q[max_len];
int len = 1;

int x_off[4] = {1, 0, -1, 0};
int y_off[4] = {0, -1, 0, 1};

int b_x;
int b_y;
int b_index;

bool inQueue(int x, int y){
    bool is = false;
    for (int i = 0; i < len; i++){
        if (q[i].y == y && q[i].x == x){
            is = true;
            break;
        }
    }

    return is;
}

void addToQueue(int x, int y, int o_index){
    q[len - 1] = st{y, x, o_index};
    len++;
}

bool notWall(int x, int y){
    if (polje[y][x] == '.')
        return true;
    else
        return false;
}

bool finish(int x, int y){
    if (polje[y][x] == 'E')
        return true;
    else
        return false;
}

bool f = false;
void found(int x, int y, int o_index){
    f = true;
    frameRate = 8;

    b_x = x;
    b_y = y;
    b_index = o_index;
}

void branch(int x, int y, int o_index){
    for (int i = 0; i < 4; i++){
        if (finish(x + x_off[i], y + y_off[i]))
            found(x + x_off[i], y + y_off[i], o_index);
    }

    if (f)
        return;

    for (int i = 0; i < 4; i++){
        if (notWall(x + x_off[i], y + y_off[i]) && (!inQueue(x + x_off[i], y + y_off[i]))){
            addToQueue(x + x_off[i], y + y_off[i], o_index);
        }
    }
}

void settings(){
    ifstream input("maze.txt");
    input >> r >> s;
    for (int i = 0; i < r; i++){
        for (int j = 0; j < s; j++){
            input >> polje[i][j];
        }
    }
    input.close();

    for (int i = 0; i < r; i++){
        for (int j = 0; j < s; j++){
            if (polje[i][j] == 'S'){
                start_y = i; start_x = j;
            }
        }
    }

    addToQueue(start_x, start_y, -1);

    glClearColor(1.0, 1.0, 1.0, 1.0);
    frameRate = 4;

    textMode(LEFT, BOTTOM);

    title = "Breadth first search";
    width = s * tile_size;
    height = r * tile_size;
}

Font f20 = Font("consolas", 20);

void setup(){

}

void draw(bool active){
    if (!f){
        int l = len;
        for (int j = 0; j < l; j++){
            branch(q[j].x, q[j].y, j);
            if (f)
                break;
        }
    }
    else {
        if (b_index != -1){
            b_x = q[b_index].x;
            b_y = q[b_index].y;
            b_index = q[b_index].o_index;

            polje[b_y][b_x] = '+';
        }
    }

    glColor3f(0.7, 0.7, 0.7);
    for (int i = 0; i < r; i++){
        for (int j = 0; j < s; j++){
            if (polje[i][j] == '#')
                glColor3f(0.7, 0.7, 0.7);
            else if (polje[i][j] == 'E')
                glColor3f(1.0, 0.3, 0.3);
            else if (polje[i][j] == '.')
                glColor3f(1.0, 1.0, 1.0);
            glRectd(tile_size * j, tile_size * i, tile_size * (j + 1), tile_size * (i + 1));
        }
    }

    glColor3f(1.0, 1.0, 0.5);
    for (int i = 0; i < len; i++){
        glRectd(tile_size * q[i].x, tile_size * q[i].y, tile_size * (q[i].x + 1), tile_size * (q[i].y + 1));
    }

    glColor3f(0.6, 0.6, 0.9);
    for (int i = 0; i < r; i++){
        for (int j = 0; j < s; j++){
            if (polje[i][j] == '+')
                glRectd(tile_size * j, tile_size * i, tile_size * (j + 1), tile_size * (i + 1));
        }
    }

    glColor3f(0.7, 0.7, 0.7);
    glRectd(0, 0, tile_size, tile_size);

    glColor3f(0.3, 1.0, 0.3);
    glRectd(start_x * tile_size, start_y * tile_size, (start_x + 1) * tile_size, (start_y + 1) * tile_size);
}

void mouse(int button, int state, int mx, int my){

}

void keyPressed(unsigned char key){

}

void keyReleased(unsigned char key){

}
