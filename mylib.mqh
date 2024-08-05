//+------------------------------------------------------------------+
//|                                                        mylib.mqh |
//|                                                          LMGFund |
//|                    https://github.com/LMGFund/mwilasfullproof_v2 |
//+------------------------------------------------------------------+
/*
   MyLib Mql5 Library
   This libary will make it easy for you to use Mql5 Standard operations when working with EAs, Scripts and Indicators.
*/

#define EXPERT_MAGIC 71311181525;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void setMqlTradeRequestParams(MqlTradeRequest &positionParams, string pairSymbol, double lotSize)
{
   positionParams.action = TRADE_ACTION_DEAL;
   positionParams.symbol = pairSymbol;
   positionParams.volume = lotSize;
   positionParams.magic = EXPERT_MAGIC;
   positionParams.deviation = 100;
}

/*
 *   Function openBuyPosition(string pairSymbol = NULL, double lotSize = 0.01, double stopLoss = NULL, double takeProfit = NULL);
 *   Function is for executing a buy order.
 *   If there is something wrong with a take profit and or stop loss values the order will fail.
 */
MqlTradeResult openBuyOrder(string pairSymbol = NULL,
                            double lotSize = 1.0,
                            double stopLoss = NULL,
                            bool isRawStop = false,
                            double takeProfit = NULL,
                            bool isRawTakeProfit = false)
{
   MqlTradeRequest positionParams = {};
   MqlTradeResult positionResutls = {};

   if (pairSymbol == NULL)
   {
      Symbol();
   }

   setMqlTradeRequestParams(positionParams, pairSymbol, lotSize);
   positionParams.type = ORDER_TYPE_BUY;
   positionParams.price = SymbolInfoDouble(pairSymbol, SYMBOL_ASK);

   if (stopLoss)
   {
      positionParams.sl = (isRawStop ? stopLoss : SymbolInfoDouble(pairSymbol, SYMBOL_BID) - convertPipsToPrice(stopLoss));
   }
   if (takeProfit)
   {
      double _takeProfitFinalValue = (isRawTakeProfit ? takeProfit : SymbolInfoDouble(pairSymbol, SYMBOL_ASK) + convertPipsToPrice(takeProfit));
      positionParams.tp = _takeProfitFinalValue;
      positionParams.volume = lotSize;
   }
   Print("[Before Convetions] Buy Position: EntryPrice=", positionParams.price, " Pair=", pairSymbol, " Stop=", stopLoss, " TP=", takeProfit, " LOTS=", lotSize, " SP Converted=", convertPipsToPrice(stopLoss), " TP Converted=", convertPipsToPrice(takeProfit), " Tick Value=", SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE));
   Print("[After Convetions] Buy Position: EntryPrice=", positionParams.price, " Pair=", pairSymbol, " Stop=", positionParams.sl, " TP=", positionParams.tp, " LOTS=", lotSize);
   if (!OrderSend(positionParams, positionResutls))
   if (!OrderSend(positionParams, positionResutls))
   {
      Alert("Failed to place an order!");
      Print(positionResutls.comment);
      Print(positionResutls.retcode);
   }

   return positionResutls;
}

/*
 *   Function openSellOrder(string pairSymbol = NULL, double lotSize = 0.01, double stopLoss = NULL, double takeProfit = NULL);
 *   Function is for executing a sell order.
 *   If there is something wrong with a take profit and or stop loss values the order will fail.
 */
MqlTradeResult openSellOrder(string pairSymbol = NULL,
                             double lotSize = 1.0,
                             double stopLoss = NULL,
                             bool isRawStop = false,
                             double takeProfit = NULL,
                             bool isRawTakeProfit = false)
{
   MqlTradeRequest positionParams = {};
   MqlTradeResult positionResutls = {};

   if (pairSymbol == NULL)
   {
      Symbol();
   }

   setMqlTradeRequestParams(positionParams, pairSymbol, lotSize);
   positionParams.type = ORDER_TYPE_SELL;
   positionParams.price = SymbolInfoDouble(pairSymbol, SYMBOL_BID);

   if (stopLoss)
   {
      positionParams.sl = (isRawStop ? stopLoss : SymbolInfoDouble(pairSymbol, SYMBOL_ASK) + convertPipsToPrice(stopLoss));
   }
   if (takeProfit)
   {
      double _takeProfitFinalValue = (isRawTakeProfit ? takeProfit : SymbolInfoDouble(pairSymbol, SYMBOL_BID) - convertPipsToPrice(takeProfit));
      positionParams.tp = _takeProfitFinalValue;
      positionParams.volume = lotSize;
   }
   Print("[Before Convetions] Sell Position: EntryPrice=", positionParams.price, " Pair=", pairSymbol, " Stop=", stopLoss, " TP=", takeProfit, " LOTS=", lotSize, " SP Converted=", convertPipsToPrice(stopLoss), " TP Converted=", convertPipsToPrice(takeProfit), " Tick Value=", SymbolInfoDouble(Symbol(), SYMBOL_POINT));
   Print("[After Convetions] Sell Position: EntryPrice=", positionParams.price, " Pair=", pairSymbol, " Stop=", positionParams.sl, " TP=", positionParams.tp, " LOTS=", lotSize);
   if (!OrderSend(positionParams, positionResutls))
   {
      Alert("Failed to place an order!");
      Print(positionResutls.comment);
      Print(positionResutls.retcode);
   }
   return positionResutls;
}

/*
 *  Function: lmg_simpleMovingAverage(handler, maPeriod, maShift, symbol, timeframe)
 *  Function initializes moving average and returns a handler.
 */
int lmg_simpleMovingAverageInit(
    int maPeriod_,
    int maShift_,
    string pairSymbol_,
    ENUM_TIMEFRAMES indicatorTimeframe_)
{
   MqlParam _mqlParams[];

   int _paramCount = 4;
   int maHandler_;

   ArrayResize(_mqlParams, _paramCount);

   if (pairSymbol_ == NULL)
      Symbol();

   for (int counter = 0; counter < _paramCount; counter++)
   {
      _mqlParams[counter].type = TYPE_INT;
   }

   _mqlParams[0].integer_value = maPeriod_;   // period
   _mqlParams[1].integer_value = maShift_;    // shift/offset
   _mqlParams[2].integer_value = MODE_SMA;    // smoothing method
   _mqlParams[3].integer_value = PRICE_CLOSE; // which price

   maHandler_ = IndicatorCreate(pairSymbol_,
                                indicatorTimeframe_,
                                IND_MA,
                                _paramCount,
                                _mqlParams);
   return (maHandler_ == INVALID_HANDLE ? INVALID_HANDLE : maHandler_);
}

/*
 *  Function: simpleMovingAverageIndicatorData(maHandler, dataPoints, indicaotData);
 *  Function returns indicator data from the buffer using a handler.
 *  Tip: Run the indicator only on price change.
 */
void lmg_simpleMovingAverageData(
    int maHandler_,
    int dataPoints_,
    double &indicatorData_[])
{
   bool _asSeries = true;

   if (maHandler_ != INVALID_HANDLE)
   {
      ArraySetAsSeries(indicatorData_, _asSeries);

      if (CopyBuffer(maHandler_, 0, 0, dataPoints_, indicatorData_) <= 0)
      {
         Print("An error happened while copy indicator buffer data: ", GetLastError());
         return;
      }
      else
      {
         // Print("Data Copied successfully to the buffer!");
         return;
      }
   }
   Print("Invalid handler returned: ", GetLastError());
}

/*
 *  Function: symbolDecimalType(void);
 *  Function returns a number of decimals for an opened Symbol.
 */
int symbolDecimalType(void)
{
   string symbols[19] = {
      "NZDJPY",
      "CADJPY",
      "CHFJPY",
      "AUDJPY",
      "USDCAD",
      "NZDUSD",
      "AUDUSD",
      "GBPUSD",
      "USDJPY",
      "EURUSD",
      "GBPJPY",
      "GBPJPYm",
      "XAUUSD",
      "USDZAR",
      "EURJPY",
      "USTECm",
      "NASUSD",
      "NAS100",
      "US100.cash"
      };
   int symbolDecimals[19] = {
      2/*NZDJPY*/,
      2/*CADJPY*/,
      2/*CHFJPY*/,
      2/*AUDJPY*/,
      4/*USDCAD*/,
      4/*NZDUSD*/,
      4/*AUDUSD*/,
      4/*GBPUSD*/,
      2/*USDJPY*/,
      4/*EURUSD*/,
      2/*GBPJPY*/,
      2/*GBPJPYm*/,
      0/*XAUUSD*/,
      4/*USDZAR*/,
      2/*EURJPY*/,
      0/*USTECm-Exness*/,
      0/*NASUSD-Khwezi*/,
      0/*NASUSD-MyForexFunds*/,
      0/*NASUSD-FTMO*/
      };
   int results = 0;

   for (int i = 0; i < (int)ArraySize(symbols); i++)
   {
      if (Symbol() == symbols[i])
      {
         results = symbolDecimals[i];
         break;
      }
   }

   return results;
}

/*
 *  Function: convertPipsToPrice(double pips = 0);
 *  Function converts given pips as a number to a symbol respective pips.
 *  Eg EURUSD 4 pips will always equal to 0.0005
 */
double convertPipsToPrice(double pips = 0)
{
   int symbolDecimalNumber = symbolDecimalType();
   int base = 10;

   return (symbolDecimalNumber == 0 ? pips : (pips / MathPow(base, symbolDecimalNumber)));
}

/*
 *  Function manages a sell positions by breaking even the trade.
 */
void sellPositionBEManager()
{
   double floatingPips = 0;
   double stopLossValue = 0;
      // 1) Move a trade above the stop loss
      if (PositionGetDouble(POSITION_SL) > PositionGetDouble(POSITION_PRICE_OPEN))
      {
         floatingPips = PositionGetDouble(POSITION_PRICE_OPEN) - PositionGetDouble(POSITION_PRICE_CURRENT);
         stopLossValue = PositionGetDouble(POSITION_SL) - PositionGetDouble(POSITION_PRICE_OPEN);
         
         if (floatingPips > stopLossValue){
            modifyStopLoss(PositionGetInteger(POSITION_TICKET), PositionGetDouble(POSITION_PRICE_OPEN), PositionGetDouble(POSITION_TP));
            Print("Sell Position Stop Loss moved to breakeven!");
         } 
      }
}

/*
 *  Function manages a buy positions by breaking even the trade.
 */
void buyPositionBEManager()
{
   double floatingPips = 0;
   double stopLossValue = 0;
      // 1) Move a trade above the stop loss
      if (PositionGetDouble(POSITION_SL) < PositionGetDouble(POSITION_PRICE_OPEN))
      {
         floatingPips = PositionGetDouble(POSITION_PRICE_CURRENT) - PositionGetDouble(POSITION_PRICE_OPEN);
         stopLossValue = PositionGetDouble(POSITION_PRICE_OPEN) - PositionGetDouble(POSITION_SL);
         
         if (floatingPips > stopLossValue){
            modifyStopLoss(PositionGetInteger(POSITION_TICKET), PositionGetDouble(POSITION_PRICE_OPEN), PositionGetDouble(POSITION_TP));
            Print("Buy Position Stop Loss moved to breakeven!");
         } 
      }
}

/*
 *  Function: modifyStopLoss(ulong ticket, double stoplossPrice);
 *  Function sets a stop loss. If your entry has a take profit the tp will be set to zero!
 *  Eg If first it set a trade to breakeven and then after it trails the trade for instance if price moves by number of pips presented by trailer
 *  then the stop loss will be moved based on pipsToMove
 */
bool modifyStopLoss(ulong ticket, double stoplossPrice, double takeProfitPrice)
{
   MqlTradeRequest mqlTradeRequest = {};
   MqlTradeResult mqlTradeResult = {};

   mqlTradeRequest.action = TRADE_ACTION_SLTP;
   mqlTradeRequest.position = ticket;
   mqlTradeRequest.symbol = Symbol();
   mqlTradeRequest.sl = stoplossPrice;
   mqlTradeRequest.tp = takeProfitPrice;
   mqlTradeRequest.magic = EXPERT_MAGIC;

   if (!OrderSend(mqlTradeRequest, mqlTradeResult))
   {
      return false;
   }

   return true;
}

/*
 *  Manages open buy and sell positions.
 */
void onCurrentPositionBEManager()
{
   for(int positionCounter = 0; positionCounter < PositionsTotal(); positionCounter++)
     {
      if(Symbol() == PositionGetSymbol(positionCounter))
        {
            if ((ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            {
               buyPositionBEManager();
            }
            
            if ((ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
            {
               sellPositionBEManager();
            }         
        }
     }
}

/*
   Draw band and give it a color
*/
/*
 *  Function: drawBand(double _previousBandValue,
 *                    datetime _fromDatetime,
 *                    double _currentBandValue,
 *                    datetime _toDatetime,
 *                    string _bandName,
 *                    color _bandColor);
 *  Function draws a band based on given parameters
 */
bool drawBand(
    double _previousBandValue,
    datetime _fromDatetime,
    double _currentBandValue,
    datetime _toDatetime,
    string _bandName,
    color _bandColor)
{
   int _chartId = 0; // current chart

   /*bool _isRendered = ObjectCreate(
       _chartId,
       _bandName,
       OBJ_TREND,
       0,
       _fromDatetime,
       _previousBandValue,
       _toDatetime,
       _currentBandValue);

   ObjectSetInteger(_chartId, _bandName, OBJPROP_COLOR, _bandColor);

   return _isRendered;*/
   return true;
}
/*
   Get X Hours Ago Date
*/
/*
 *  Function: getXHoursAgoDate(int hours_);
 *  Function gets previous x time from the number of hours ago.
 */
datetime getXHoursAgoDate(int hours_)
{
   return (hours_ == NULL || hours_ < 1 ? TimeCurrent() : TimeCurrent() - (3600 * hours_));
}
/*
   Load previous history data
*/
/*
*  Function: loadHistoryData(MqlRates& historyData[],
                             int hours,
                             ENUM_TIMEFRAMES timeFrame);
*  Function loads history data based on given input
*/
bool loadHistoryData(MqlRates &historyData[], int hours, ENUM_TIMEFRAMES timeFrame)
{

   datetime _fromDate = getXHoursAgoDate(hours);

   datetime _toDate = TimeCurrent();
   // Print("Your date: ",_fromDate);

   int copyRatesStatus = CopyRates(Symbol(), timeFrame, _fromDate, _toDate, historyData);

   if (copyRatesStatus <= 0)
   {
      Print("Unable to retrieve data");
      return true;
   }
   else
   {
      // Print("Data successfully retrieved");
      return false;
   }
}

/*
   Initiate Average True Range
*/
/*
*  Function: averageTrueRangeIndicatorInit(
                     int& _atrHandler,
                     int _lookbackPeriod,
                     string _pairSymbol,
                      ENUM_TIMEFRAMES timeFrame);
*  Function initiates the average true range for later use
*/
void averageTrueRangeIndicatorInit(
    int &_atrHandler,
    int _lookbackPeriod,
    string _pairSymbol,
    ENUM_TIMEFRAMES timeFrame)
{
   MqlParam _indicatorParameters[1];
   int _parameterCount = 1;

   if (_pairSymbol == NULL)
   {
      _pairSymbol = Symbol();
   }

   _indicatorParameters[0].type = TYPE_INT;                 // indicator parameter type (lookback period)
   _indicatorParameters[0].integer_value = _lookbackPeriod; // lookback period

   _atrHandler = IndicatorCreate(_pairSymbol, timeFrame, IND_ATR, _parameterCount, _indicatorParameters);
}

/*
   Return Average True Range Data
*/
/*
*  Function: averageTrueRangeIndicatorData(
                     double& _averageTrueRangeData[],
                     int _atrHandler,
                     uint _dataPoints);
*  Function return average true range data from the terminal memory
*/
void averageTrueRangeIndicatorData(
    double &_averageTrueRangeData[],
    int _atrHandler,
    uint _dataPoints)
{
   bool _asSeries = true;

   if (_atrHandler != INVALID_HANDLE)
   {
      ArraySetAsSeries(_averageTrueRangeData, _asSeries);

      if (CopyBuffer(_atrHandler, 0, 0, _dataPoints, _averageTrueRangeData) == 0)
      {
         Print("An error happened while copy indicator buffer data: ", GetLastError());
      }
   }
}

/*
   Draw Text and give it a color
*/
/*
*  Function: drawText(long ChartID_,
              string labelName_,
              string textToPrint_,
              int xAxis_,
              int yAxis_,
              ENUM_BASE_CORNER positionOnChart_,
              int fontSize_,
              color fontColor_,
              ENUM_ANCHOR_POINT textAnchor
*  Function draws a text based on given parameters
*/
void drawText(long ChartID_,
              string labelName_,
              string textToPrint_,
              int xAxis_,
              int yAxis_,
              ENUM_BASE_CORNER positionOnChart_,
              int fontSize_,
              color fontColor_,
              ENUM_ANCHOR_POINT textAnchor_)
{
   int _zero = 0;

   datetime _xAxisPoint = 0;

   double _yAxisPoint = 0;

   string _font = "Arial";

   bool _isFalse = false;
   bool _isTrue = true;

   if (!ObjectCreate(ChartID_, labelName_, OBJ_LABEL, _zero, _xAxisPoint, _yAxisPoint))
   {
      Print(__FUNCTION__, ": failed to create text label! Error code = ", GetLastError());
      return;
   }

   ObjectSetInteger(ChartID_, labelName_, OBJPROP_XDISTANCE, xAxis_);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_YDISTANCE, yAxis_);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_CORNER, positionOnChart_);
   ObjectSetString(ChartID_, labelName_, OBJPROP_TEXT, textToPrint_);
   ObjectSetString(ChartID_, labelName_, OBJPROP_FONT, _font);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_FONTSIZE, fontSize_);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_COLOR, fontColor_);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_SELECTABLE, _isFalse);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_SELECTED, _isFalse);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_SELECTED, _isFalse);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_ANCHOR, textAnchor_);
   ObjectSetInteger(ChartID_, labelName_, OBJPROP_BACK, _isTrue);
}

/*
   Check if is before cut off time in this case,
   checks if it is before 22H00 if yes it returns
   True and if no it returns false
*/
bool isBeforeCutOff(int setStart)
{
   return cutOffTime("before", setStart);
}

/*
   Check if is after cut off time in this case,
   checks if it is after 02H00 if yes it returns
   True and if no it returns false
*/
bool isAfterCutOff(int riseStart)
{
   return cutOffTime("after", riseStart);
}

bool cutOffTime(string type, int hour)
{
   datetime currentTime = TimeCurrent();
   MqlDateTime currentTimeStruct;

   TimeToStruct(currentTime, currentTimeStruct);

   if (type == "after")
   {
      return currentTimeStruct.hour < hour;
   }

   if (type == "before")
   {
      return currentTimeStruct.hour > hour;
   }
   return false;
}

//+------------------------------------------------------------------+
