#include "LibraryBase.h"
#include "LiquidCrystal.h"

const char MSG_pLCD_CREATE_LCD_SHIELD[]       PROGMEM = "Arduino::pLCD = new LiquidCrystal(%d, %d, %d, %d, %d, %d);\n";
const char MSG_pLCD_INITIALIZE_LCD_SHIELD[]   PROGMEM = "Arduino::pLCD->begin(%d, %d);\n";
const char MSG_pLCD_CLEAR_LCD_SHIELD[]        PROGMEM = "Arduino::pLCD->clear();\n";
const char MSG_pLCD_PRINT[]                   PROGMEM = "Arduino::pLCD->print(%s);\n";
const char MSG_SET_CURSOR_LCD_SHIELD[]        PROGMEM = "Arduino::pLCD->setCursor(%d, %d);\n";
const char MSG_pLCD_DELETE_LCD_SHIELD[]       PROGMEM = "Arduino::delete pLCD;\n";

#define LCD_CREATE      0x00
#define LCD_INITIALIZE  0x01
#define LCD_CLEAR       0x02
#define LCD_PRINT       0x03
#define LCD_DELETE      0x04

byte cursorRow = 0;

class LCD : public LibraryBase
{
public:
    LiquidCrystal *pLCD;
public:
    LCD(MWArduinoClass& a)
    {
        libName = "ExampleShield/LCD";
        a.registerLibrary(this);
    }
	
	void setup()
    {
        cursorRow = 0;
    }
public:
    void commandHandler(byte cmdID, byte* dataIn, unsigned int payloadSize)
    {
        switch(cmdID)
        {
            case LCD_CREATE:  //createLCD
            {
                byte* pinNumbers = new byte [6];
                for (byte i=0; i<6; i=i+1)
                {
                    pinNumbers[i] = dataIn[i];
                }
                createLCDObject(pinNumbers[0],pinNumbers[1],pinNumbers[2],pinNumbers[3],pinNumbers[4],pinNumbers[5]);
                sendResponseMsg(cmdID, 0, 0);
                break;
            }
            case LCD_INITIALIZE:  //initializeLCD
            {
                unsigned int rows = dataIn[0];
                unsigned int cols = dataIn[1];
                initializeLCD(rows,cols);
                clearLCD();
                sendResponseMsg(cmdID, 0, 0);
                break;
            }
			case LCD_CLEAR:  //clearLCD
            {
                clearLCD();
                cursorRow = 0;
                setCursor(0, cursorRow);
                sendResponseMsg(cmdID, 0, 0);
                break;
            }
			case LCD_PRINT:  //printLCD
            {
                byte* val = {dataIn};
                // last byte is the number of rows initialized
                // last 2nd byte is the number of columns initialized
                char message[payloadSize-1];
                for(byte k=0; k<(payloadSize-2); k=k+1)
                {
                    message[k]=val[k];
                }
                message[payloadSize-2] = '\0';
                
                byte cols = val[payloadSize-2];
                byte rows = val[payloadSize-1];

                if(cursorRow+1 > rows){
                    cursorRow = 0;
                    clearLCD();
                }
                setCursor(0,cursorRow);
                printLCD(message);
                cursorRow++;
                    
                sendResponseMsg(cmdID, 0, 0);
                break;
            }
			case LCD_DELETE:  //delete
            {
                deleteLCDobject();
                //reset the cursor position to the first row on deletion
                cursorRow = 0;
                sendResponseMsg(cmdID, 0, 0);
                break;
            }
            default:
            {
                // Do nothing
                break;
            }
public:
	void createLCDObject(unsigned int rs,unsigned int enable,unsigned int d0,unsigned int d1,unsigned int d2,unsigned int d3)
	{
		 pLCD = new LiquidCrystal(rs, enable, d0, d1, d2, d3);
		 debugPrint(MSG_pLCD_CREATE_LCD_SHIELD,rs,enable,d0,d1,d2,d3);
	}
	void initializeLCD(unsigned int cols,unsigned int rows)
	{
		pLCD->begin(cols, rows);
		debugPrint(MSG_pLCD_INITIALIZE_LCD_SHIELD, cols, rows);
	}
	void clearLCD()
	{
		pLCD->clear();
		debugPrint(MSG_pLCD_CLEAR_LCD_SHIELD);
	}
	void printLCD(char message[])
	{
		pLCD->print(message);
		debugPrint(MSG_pLCD_PRINT, message);
	}
	void setCursor(byte column, byte row)
	{
		pLCD->setCursor(column, row);
		debugPrint(MSG_SET_CURSOR_LCD_SHIELD,column,row);
	}
	void deleteLCDobject()
	{
		delete pLCD;
		debugPrint(MSG_pLCD_DELETE_LCD_SHIELD);
	}
};