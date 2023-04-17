#include <iostream>
#include <framework.h>
#include <irrKlang.h>

//Transition stages
#define MAIN_MENU_IN 0
#define MAIN_MENU 1
#define MAIN_MENU_OUT 2
#define QUESTION_IN 3
#define QUESTION 4
#define QUESTION_OUT 5
#define WIN_IN 6
#define WIN 7
#define WIN_OUT 8
#define LOSS_IN 9
#define LOSS 10
#define LOSS_OUT 11
#define QUESTION_IN_1 12
#define QUESTION_SHOW 13
#define PRIZE_IN 14
#define PRIZE 15
#define PRIZE_OUT 16

using namespace std;
using namespace irrklang;

//Sound
ISoundEngine* sound;

void playSound(string filename){
    sound -> play2D(&filename[0], false);
}

void loopSound(string filename){
    sound -> play2D(&filename[0], true);
}

void stopSounds(){
    sound -> stopAllSounds();
}

//Variables
GUI gui;
Button button0;
Button button1;
Button button2;
Button button3;
Button ff;
Button leave;
Animation anim;

Font f20("consolas", 20);
Font f40("consolas", 40);
Font f100("consolas", 100);

bool press_available = false;
bool fifty_fifty = true;
int transition = MAIN_MENU_IN;

int shown = -1;

int question_number = 0;
int selectedAnswer = -1;

int osigurana_zarada = -1;
bool lost = false;

Image background;
Image main_menu;
Image end_screen;

Image ff_true;
Image ff_false;

string questions[15];
string answer[15][4];

int correct[15];

//Callbacks
void btn0(Button* btnptr, bool type, bool side){
    if (type == 1 && side == 0 && transition == QUESTION)
        selectedAnswer = 0;
}

void btn1(Button* btnptr, bool type, bool side){
    if (type == 1 && side == 0 && transition == QUESTION)
        selectedAnswer = 1;
}

void btn2(Button* btnptr, bool type, bool side){
    if (type == 1 && side == 0 && transition == QUESTION)
        selectedAnswer = 2;
}

void btn3(Button* btnptr, bool type, bool side){
    if (type == 1 && side == 0 && transition == QUESTION)
        selectedAnswer = 3;
}

void Fifty_fifty_btn(Button* btnptr, bool type, bool side){
    if (type == 1 && fifty_fifty == true && transition == QUESTION){
        fifty_fifty = false;
        shown = (correct[question_number] + (rand()%3 + 1)) % 4;
    }
}

void Leave_btn(Button* btnptr, bool type, bool side){
    if (type == 1 && transition == QUESTION){
        transition = QUESTION_OUT;
        stopSounds();
        lost = true;
        anim.addAnimation("fade", 1500, EASE_OUT);
        shown = -1;
    }
}

int zarada(int i){
    int rtr_val;
    switch (i){
        case 0:{rtr_val = 100;break;}
        case 1:{rtr_val = 200;break;}
        case 2:{rtr_val = 300;break;}
        case 3:{rtr_val = 500;break;}
        case 4:{rtr_val = 1000;break;}
        case 5:{rtr_val = 2000;break;}
        case 6:{rtr_val = 4000;break;}
        case 7:{rtr_val = 8000;break;}
        case 8:{rtr_val = 16000;break;}
        case 9:{rtr_val = 32000;break;}
        case 10:{rtr_val = 64000;break;}
        case 11:{rtr_val = 125000;break;}
        case 12:{rtr_val = 250000;break;}
        case 13:{rtr_val = 500000;break;}
        case 14:{rtr_val = 1000000;break;}
    }
    return rtr_val;
}

//FUNCTIONS -------------------------------------------
void settings(){
    title = "Milijunas iz Emše";
    width = 1024;
    height = 768;
    frameRate = 60;

    textMode(CENTER, CENTER);
}

void setup(){
    srand(time(0));
    ifstream file("baza.txt");
    for (int i = 0; i < 15; i++){
        string tmp;
        getline(file, questions[i]); file.sync();
        getline(file, answer[i][0]); file.sync();
        getline(file, answer[i][1]); file.sync();
        getline(file, answer[i][2]); file.sync();
        getline(file, answer[i][3]); file.sync();
        getline(file, tmp); file.sync();

        correct[i] = tmp[0] - 'a';
    }
    file.close();

    main_menu.read("Images/main_menu.bmp");
    background.read("Images/background.bmp");
    end_screen.read("Images/end_screen.bmp");

    ff_true.read("Images/5050.bmp");
    ff_false.read("Images/5050_gray.bmp");

    sound = createIrrKlangDevice();

    anim.addAnimation("fade", 3000, EASE_OUT);

    button0.init(95, 551, 409, 37);
    button0.registerActionCallback(btn0);
    gui.addButton(button0, "0");

    button1.init(95, 597, 409, 37);
    button1.registerActionCallback(btn1);
    gui.addButton(button1, "1");

    button2.init(521, 551, 409, 37);
    button2.registerActionCallback(btn2);
    gui.addButton(button2, "2");

    button3.init(521, 597, 409, 37);
    button3.registerActionCallback(btn3);
    gui.addButton(button3, "3");

    ff.init(849 - 25, 668, 75, 75);
    ff.registerActionCallback(Fifty_fifty_btn);
    gui.addButton(ff, "ff");

    leave.init(949 - 25, 668, 75, 75, "Images/leave.bmp");
    leave.registerActionCallback(Leave_btn);
    gui.addButton(leave, "leave");

    registerGui(&gui);

    loopSound("Sounds/main_menu.wav");
}

void draw(){
    anim.update();
    switch (transition){
    case MAIN_MENU_IN:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        main_menu.draw(0, 0, width, height, CORNER);
        glColor4f(0.0, 0.0, 0.0, 1.0 - anim.getValue("fade"));
        glRectd(0, 0, width, height);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            transition = MAIN_MENU;
            glColor4f(1.0, 1.0, 1.0, 1.0);
        }
    break;}

    case MAIN_MENU:{
        main_menu.draw(0, 0, width, height, CORNER);
    break;}

    case MAIN_MENU_OUT:{
        sound -> setSoundVolume(1.0 - anim.getValue("fade"));

        glColor4f(1.0, 1.0, 1.0, 1.0);
        main_menu.draw(0, 0, width, height, CORNER);
        glColor4f(0.0, 0.0, 0.0, anim.getValue("fade"));
        glRectd(0, 0, width, height);

        if (anim.isFinished("fade")){
            stopSounds();
            sound -> setSoundVolume(1);

            anim.removeAnimation("fade");
            transition = PRIZE_IN;
            glColor4f(1.0, 1.0, 1.0, 1.0);
            anim.addAnimation("fade", 3000, EASE_OUT);
        }
    break;}

    case QUESTION_IN:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        background.draw(0, 0, width, height, CORNER);
        f100.setColor(255, 255, 255);
        text("100", 510, 266, &f100);

        glColor4f(0.0, 0.0, 0.0, 1.0 - anim.getValue("fade"));
        glRectd(0, 0, width, height);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            transition = QUESTION_IN_1;
            glColor4f(1.0, 1.0, 1.0, 1.0);
            anim.addAnimation("fade", 1500, EASE_OUT);
            f20.setColor(255, 255, 255);
        }
    break;}

    case QUESTION_IN_1:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        background.draw(0, 0, width, height, CORNER);
        text("100", 510, 266, &f100);

        f20.setColor(255, 255, 255, 255 * anim.getValue("fade"));
        text(questions[question_number], 512, 504, &f20);
        text(answer[question_number][0], 299, 569, &f20);
        text(answer[question_number][1], 299, 615, &f20);
        text(answer[question_number][2], 725, 569, &f20);
        text(answer[question_number][3], 725, 615, &f20);

        glColor4f(1.0, 1.0, 1.0, 1.0);

        if (anim.isFinished("fade")){
            playSound("Sounds/question.wav");
            t_start(3);
            Sleep(1000);
            f20.setColor(255, 255, 255);

            selectedAnswer = -1;
            shown = -1;

            transition = QUESTION;
            anim.removeAnimation("fade");
        }
    break;}

    case QUESTION:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        background.draw(0, 0, width, height, CORNER);

        t_stop(3);
        int time_left = 101 - t_millis(3) / 1000;
        text(to_string(time_left), 510, 266, &f100);

        text(questions[question_number], 512, 504, &f20);

        text(answer[question_number][0], 299, 569, &f20);
        text(answer[question_number][1], 299, 615, &f20);
        text(answer[question_number][2], 725, 569, &f20);
        text(answer[question_number][3], 725, 615, &f20);

        glColor4f(1.0, 1.0, 1.0, 1.0);
        gui.draw();
        if (fifty_fifty)
            ff_true.draw(849 - 25, 668, 75, 75, CORNER);
        else
            ff_false.draw(849 - 25, 668, 75, 75, CORNER);

        if (shown != -1){
            f20.setColor(140, 255, 140);
            switch (correct[question_number]){
            case 0:
                text(answer[question_number][0], 299, 569, &f20);
            break;

            case 1:
                text(answer[question_number][1], 299, 615, &f20);
            break;

            case 2:
                text(answer[question_number][2], 725, 569, &f20);
            break;

            case 3:
                text(answer[question_number][3], 725, 615, &f20);
            break;
            }

            switch (shown){
            case 0:
                text(answer[question_number][0], 299, 569, &f20);
            break;

            case 1:
                text(answer[question_number][1], 299, 615, &f20);
            break;

            case 2:
                text(answer[question_number][2], 725, 569, &f20);
            break;

            case 3:
                text(answer[question_number][3], 725, 615, &f20);
            break;
            }
            f20.setColor(255, 255, 255);
        }
        glColor4f(1.0, 1.0, 1.0, 1.0);

        if (time_left <= 0){
            transition = QUESTION_OUT;
            stopSounds();
            lost = true;
            anim.addAnimation("fade", 1500, EASE_OUT);
            shown = -1;
        }

        if (selectedAnswer != -1){
            stopSounds();
            if (selectedAnswer == correct[question_number]){
                playSound("Sounds/correct.wav");
            }
            else{
                playSound("Sounds/wrong.wav");
            }
            t_start(3);
            transition = QUESTION_SHOW;
            shown = -1;
        }
    break;}

    case QUESTION_SHOW:{
        background.draw(0, 0, width, height, CORNER);

        text(questions[question_number], 512, 504, &f20);

        if (selectedAnswer == 0)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50);
            else
                f20.setColor(255, 50, 50);
        else
            f20.setColor(255, 255, 255);
        text(answer[question_number][0], 299, 569, &f20);
        if (selectedAnswer == 1)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50);
            else
                f20.setColor(255, 50, 50);
        else
            f20.setColor(255, 255, 255);
        text(answer[question_number][1], 299, 615, &f20);
        if (selectedAnswer == 2)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50);
            else
                f20.setColor(255, 50, 50);
        else
            f20.setColor(255, 255, 255);
        text(answer[question_number][2], 725, 569, &f20);
        if (selectedAnswer == 3)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50);
            else
                f20.setColor(255, 50, 50);
        else
            f20.setColor(255, 255, 255);
        text(answer[question_number][3], 725, 615, &f20);
        f20.setColor(255, 255, 255);
        glColor3f(1.0, 1.0, 1.0);

        glColor4f(1.0, 1.0, 1.0, 1.0);

        t_stop(3);
        if (t_millis(3) >= 3000){
            stopSounds();

            anim.removeAnimation("fade");
            anim.addAnimation("fade", 1500, EASE_OUT);

            transition = QUESTION_OUT;
        }
    break;
    }

    case QUESTION_OUT:{
        background.draw(0, 0, width, height, CORNER);

        glColor4f(1.0, 1.0, 1.0, 1.0);

        glColor4f(0.0, 0.0, 0.0, anim.getValue("fade"));
        glRectd(0, 0, width, height);

        f20.setColor(255, 255, 255, (int) (255 - 255 * anim.getValue("fade")));
        text(questions[question_number], 512, 504, &f20);

        if (selectedAnswer == 0)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50, (int) (255 - 255 * anim.getValue("fade")));
            else
                f20.setColor(255, 50, 50, (int) (255 - 255 * anim.getValue("fade")));
        else
            f20.setColor(255, 255, 255, (int) (255 - 255 * anim.getValue("fade")));
        text(answer[question_number][0], 299, 569, &f20);
        if (selectedAnswer == 1)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50, (int) (255 - 255 * anim.getValue("fade")));
            else
                f20.setColor(255, 50, 50, (int) (255 - 255 * anim.getValue("fade")));
        else
            f20.setColor(255, 255, 255, (int) (255 - 255 * anim.getValue("fade")));
        text(answer[question_number][1], 299, 615, &f20);
        if (selectedAnswer == 2)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50, (int) (255 - 255 * anim.getValue("fade")));
            else
                f20.setColor(255, 50, 50, (int) (255 - 255 * anim.getValue("fade")));
        else
            f20.setColor(255, 255, 255, (int) (255 - 255 * anim.getValue("fade")));
        text(answer[question_number][2], 725, 569, &f20);
        if (selectedAnswer == 3)
            if (selectedAnswer == correct[question_number])
                f20.setColor(50, 255, 50, (int) (255 - 255 * anim.getValue("fade")));
            else
                f20.setColor(255, 50, 50, (int) (255 - 255 * anim.getValue("fade")));
        else
            f20.setColor(255, 255, 255, (int) (255 - 255 * anim.getValue("fade")));
        text(answer[question_number][3], 725, 615, &f20);
        f20.setColor(255, 255, 255);
        glColor3f(1.0, 1.0, 1.0);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            anim.addAnimation("fade", 1500, EASE_OUT);

            if (lost){
                transition = LOSS_IN;
                break;
            }

            if (question_number == 14){
                if (selectedAnswer == correct[question_number]){
                    transition = WIN_IN;
                }
                else{
                    transition = LOSS_IN;
                }
            }
            else {
                if (selectedAnswer == correct[question_number]){
                    transition = PRIZE_IN;
                    f20.setColor(0, 0, 0);
                    question_number++;
                }
                else{
                    transition = LOSS_IN;
                }
            }
        }
    }
    break;

    case PRIZE_IN:{
        glColor4f(0, 0, 0, 1.0 - anim.getValue("fade"));
        glRectd(0, 0, width, height);

        f40.setColor(0, 0, 0);
        if (question_number == 5 || question_number == 10){
            text("Osvojili ste " + to_string(zarada(question_number - 1)) + " kuna, slijedi pitanje za " + to_string(zarada(question_number)) + " kuna.", width / 2, height / 2, &f20);
            osigurana_zarada = zarada(question_number - 1);
        }
        else
            text("Slijedi pitanje za " + to_string(zarada(question_number)) + " kuna.", width / 2, height / 2, &f40);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            transition = PRIZE;
            anim.addAnimation("fade", 1500, EASE_OUT);
        }
    }
    break;

    case PRIZE:{
        if (question_number == 5 || question_number == 10)
            text("Osvojili ste " + to_string(zarada(question_number - 1)) + " kuna, slijedi pitanje za " + to_string(zarada(question_number)) + " kuna.", width / 2, height / 2, &f20);
        else
            text("Slijedi pitanje za " + to_string(zarada(question_number)) + " kuna.", width / 2, height / 2, &f40);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            anim.addAnimation("fade", 2000, EASE_OUT);
            transition = PRIZE_OUT;

            if (question_number == 5 || question_number == 10)
                fifty_fifty = true;
        }
    }
    break;

    case PRIZE_OUT:{
        glColor4f(0, 0, 0, anim.getValue("fade"));
        glRectd(0, 0, width, height);

        f40.setColor(0, 0, 0);
        if (question_number == 5 || question_number == 10)
            text("Osvojili ste " + to_string(zarada(question_number - 1)) + " kuna, slijedi pitanje za " + to_string(zarada(question_number)) + " kuna.", width / 2, height / 2, &f20);
        else
            text("Slijedi pitanje za " + to_string(zarada(question_number)) + " kuna.", width / 2, height / 2, &f40);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            anim.addAnimation("fade", 1500, EASE_OUT);

            transition = QUESTION_IN;
        }
    }
    break;

    case WIN_IN:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        end_screen.draw(0, 0, width, height, CORNER);
        glColor4f(0.0, 0.0, 0.0, 1.0 - 1.0 * anim.getValue("fade"));
        glRectd(0, 0, width, height);

        f40.setColor(255, 255, 255, 255 * anim.getValue("fade"));
        text("POSTALI STE MILIJUNAS!!!", width / 2, height / 2, &f40);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            playSound("Sounds/win.wav");
            Sleep(10000);
            t_start(3);
            playSound("Sounds/celebration.wav");
            transition = WIN;
            glColor4f(1.0, 1.0, 1.0, 1.0);
        }
    }
    break;

    case WIN:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        end_screen.draw(0, 0, width, height, CORNER);

        int x = rand()%424 + 300;
        int y = rand()%468 + 150;

        int r = rand()%100 + 155;
        int g = rand()%100 + 155;
        int b = rand()%100 + 155;

        f40.setColor(r, g, b);
        text("POSTALI STE MILIJUNAS!!!", x, y, &f40);

        Sleep(500);
        t_stop(3);
        if (t_millis(3) > 257000){
            stopSounds();
            close();
        }
    }
    break;

    case LOSS_IN:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        glRectd(0, 0, width, height);
        glColor4f(0.0, 0.0, 0.0, 1.0 - 1.0 * anim.getValue("fade"));
        glRectd(0, 0, width, height);

        f40.setColor(0, 0, 0, 255);
        if (osigurana_zarada == -1)
            text("Niste nista zaradili...", width / 2, height / 2, &f40);
        else
            text("Zaradili ste " + to_string(osigurana_zarada) + " kuna!", width / 2, height / 2, &f40);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");
            t_start(3);
            transition = LOSS;
            f40.setColor(0, 0, 0, 255);
        }
    }
    break;

    case LOSS:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        glRectd(0, 0, width, height);

        if (osigurana_zarada == -1)
            text("Niste nista zaradili...", width / 2, height / 2, &f40);
        else
            text("Zaradili ste " + to_string(osigurana_zarada) + " kuna!", width / 2, height / 2, &f40);

        t_stop(3);
        if (t_millis(3) > 2000){
            transition = LOSS_OUT;
            anim.addAnimation("fade", 2000, EASE_OUT);
        }
    }
    break;

    case LOSS_OUT:{
        glColor4f(1.0, 1.0, 1.0, 1.0);
        glRectd(0, 0, width, height);
        glColor4f(0.0, 0.0, 0.0, 1.0 * anim.getValue("fade"));
        glRectd(0, 0, width, height);

        f40.setColor(0, 0, 0, 255);
        if (osigurana_zarada == -1)
            text("Niste nista zaradili...", width / 2, height / 2, &f40);
        else
            text("Zaradili ste " + to_string(osigurana_zarada) + " kuna!", width / 2, height / 2, &f40);

        if (anim.isFinished("fade")){
            anim.removeAnimation("fade");

            transition = MAIN_MENU_IN;

            press_available = false;
            fifty_fifty = true;

            shown = -1;

            question_number = 0;
            selectedAnswer = -1;

            osigurana_zarada = -1;

            lost = false;

            anim.addAnimation("fade", 3000, EASE_OUT);
            loopSound("Sounds/main_menu.wav");
        }
    }
    break;

    }
}

void mouse(int button, int state, int mx, int my){
    if (transition == MAIN_MENU){
        transition = MAIN_MENU_OUT;
        anim.addAnimation("fade", 3000, EASE_OUT);
    }
}

void keyPressed(unsigned char key){

}

void keyReleased(unsigned char key){

}

void close(){
    sound -> drop();
    sound = 0;
    glutLeaveMainLoop();
    exit(0);
}
