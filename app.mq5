/*
  Start: Imports
*/

#include "InformationPanel.mqh"
#include "mylib.mqh"

/*
   Start: EA Input
*/

//  Start: ROI
input double PercentageToRisk = 1; // Percentage to Risk
input double RiskToRewardRatio = 2; // Risk to reward

//  Start: Cut off times
input int RiseStart = 8; // Start of the session 8 = 8:00
input int SetStart = 22; // End of the session 22 = 22:00

/*
   End: EA Input
*/

int OnInit() {
    //---
    long   chartId             = ChartID();
    string chartPanelName      = "Trend Information";   // Panel Name
    int    chartSubWindow      = 0;                     // Current Window
    int    upperLeftCorner_x1  = 40;
    int    upperLeftCorner_y1  = 40;
    int    lowerRightCorner_x2 = 500;
    int    lowerRightCorner_y2 = 500;

    if(!InfoPanel.Create(chartId, chartPanelName, chartSubWindow, upperLeftCorner_x1, upperLeftCorner_y1, lowerRightCorner_x2, lowerRightCorner_y2)) {
        return (INIT_FAILED);
    }
    InfoPanel.SetStartUpValues((RiseStart < 12 ? DoubleToString(RiseStart, 2) + " AM" : DoubleToString(RiseStart, 2) + " PM"),
                               (SetStart < 12 ? DoubleToString(SetStart, 2) + " AM" : DoubleToString(SetStart, 2) + " PM"),
                               DoubleToString(PercentageToRisk, 2) + "%",
                               "1.0 : " + DoubleToString(RiskToRewardRatio, 2));
    //--- Enable Auto Trader Switch and Dynamic Auto Trader
    if (MQLInfoInteger(MQL_TESTER))
    {
      InfoPanel.SetStaticAutoTradeStatus(true);
      InfoPanel.SetDynamicAutoTradeStatus(true);
    }
//--- run application
   InfoPanel.Run();
    //---
    return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    //---
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    //---
}
//+------------------------------------------------------------------+
