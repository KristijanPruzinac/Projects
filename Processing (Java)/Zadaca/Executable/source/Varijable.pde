String[] zadaci_lista;

//trenutačni datum
int day = day();
int month = month();
int year = year();

int[] month_lengths = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
int date;


//liste zadataka i oznaka
ArrayList<zadatak> zadaci = new ArrayList<zadatak>();

//pracenje sekundi
int last_sec = 0;
int this_sec = 0;

int hour;
int minute;
int second;

String hour_string;
String minute_string;
String second_string;

//zadaci i scroll
int zadaci_offset = 0;
int scroll_length;
int scroll_pos = 0;

int scroll_start = 0;
int scroll_end = 0;

//window
String window = "Zadaci";

//add bar settings
int selected_add_element = -1;

String add_ime = "";
String add_opis = "";
String add_day = "";
String add_month = "";

//aktivan predmet
int aktivan_element = -1;
