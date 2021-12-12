#include "SO_Follow_Settings.mq5"
#include "SO_Follow_Settings_Evo.mq5"
//#include "SO_Follow_v1.mq5"
#include "SO_Follow_v2.mq5"
//#include "SO_Follow_v3.mq5"
//#include "SO_Follow_v4.mq5"
#include "SO_Follow_v5.mq5"
//#include "SO_Follow_v6.mq5"
//#include "SO_Follow_v7.mq5"
#include "Principal_HTF.mq5"


void controleHTF(int callFrom)
{

    int response = 0;


    switch(SELECTED_VER) // Version
    {                                                           
        case 1:
            if(SELECTED_EN_MODE == 1)
            {
                response = principalHTF(callFrom); 
            }
            else
            {
       //         response = Sys_Follow_4_9_3(callFrom); 
            }
            break;                                                                                                                                                                                  
    }

}
