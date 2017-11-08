integer toggle = TRUE;
integer HP = 45;
integer MP = 20;
integer HPchange;
integer MPchange;
integer turnOrder = FALSE;

integer listen_handle;

integer RandomNumber(integer min, integer max)
{
    return min + (integer)(llFrand(max - min + 1)); 
}

DisplayStats()
{
    integer count;
    string h = "";
    string m = "";
    integer health = HP;
    integer mana = MP;
    h = (string)health;
    m = (string)mana;
    
 llSetText("HP: " + h + 
        "\nMP: " + m + 
        "\nLast Health Change:  " + (string)HPchange + 
        "\nLast Mana Change: " + (string)MPchange, <1,1,1>, 1.5);     
}

default
{
    state_entry()
    {
        if (HP <= 0)
        {
            llSay(0, "I have fallen to the hero! Game over.");
            llSleep(5.0);
            llSay(6, "Reset");
            llResetScript();
        }
        
        if (turnOrder == FALSE)
        {
        listen_handle = llListen(5, "", NULL_KEY, "");
        DisplayStats();
        }
    }
    listen( integer channel, string name, key id, string message )
    {
    if (message == "Reset")
            {
                llResetScript();
            }
        
      if (channel == 5)
      {
          if (message == "Attack")
          {
          HPchange = RandomNumber(2, 8);
            
          HP = HP - HPchange;
          DisplayStats();
          turnOrder = TRUE;
          state two;
          }
          if (message == "Heal")
          {
          turnOrder = TRUE;
          state two;
          }
          if (message == "Charge")
          {
          turnOrder = TRUE;
          state two;
          }
          if (message == "Reset")
            {
                llResetScript();
            }
          
      }  
    }
}
state two
{
    state_entry()
    {
         if (HP <= 0)
        {
            llSay(0, "I have fallen to the hero! Game over.");
            llSleep(5.0);
            llSay(6, "Reset");
            llResetScript();
        }
        if (turnOrder == TRUE)
        {
            llSay(0, "Thinking...");
            llSleep(2.0);
            if (HP > 10)
            {
                llSay(6, "Attack");
                llSay(0, "Die!");
                turnOrder = FALSE;
                state default;
            }
            else if(MP <= 4)
            {
                llSay(0, "Give me your mana!");
                llSay(6, "Mana");
                MPchange = RandomNumber(1, 5);
                MP = MP + MPchange;
                DisplayStats();
                turnOrder = FALSE;
                state default;
            }
            else if (HP <= 10)
            {
                llSay(0, "I'm healing!");
                llSay(6, "Heal");
                HPchange = 4;
                MPchange = RandomNumber(1, 4);
                
                MP = MP - MPchange;
                HP = HP + HPchange;
                DisplayStats();
                turnOrder = FALSE;
                state default;
            }
        }
    }
}