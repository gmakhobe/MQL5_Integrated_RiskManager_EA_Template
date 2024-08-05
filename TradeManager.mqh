//+------------------------------------------------------------------+
//|                                                TradeManager_.mqh |
//|                                                          LMGFund |
//|                    https://github.com/LMGFund/mwilasfullproof_v2 |
//+------------------------------------------------------------------+

/*
   Manage Trades for the EA
*/
/*
*  Function: tradeManager(
                           ...
*  Function manages trades for this EA
*/
void tradeManager(bool tradeManager_TradeWeakSignals_,
                  bool tradeManager_TradeModerateSignals_,
                  bool tradeManager_TradeStrongSignals_)
  {
   if(tradeManager_TradeWeakSignals_)
     {
      // Logic
     }
   if(tradeManager_TradeModerateSignals_)
     {
      // Logic
     }
   if(tradeManager_TradeStrongSignals_)
     {
      // Logic
     }
  }

/*
   Chooses between defined stop orders & Super trend bands as stop orders
*/
/*
*  Function: tradeManagerRiskDefinedStopOrder(
                           ...
*  Function returns true for defined stop orders and false for Super Trend as Stop Orders
*/
bool tradeManagerRiskDefinedStopOrder(bool tradeManager_UseDefinedStopOrder_,
                                      bool tradeManager_UseSPBands_)
  {
   bool _isFalse = false;
   bool _isTrue = true;

   if((tradeManager_UseDefinedStopOrder_ && tradeManager_UseSPBands_) ||
      (!tradeManager_UseDefinedStopOrder_ && !tradeManager_UseSPBands_))
     {
      return _isFalse;
     }
   if(tradeManager_UseDefinedStopOrder_)
     {
      return _isTrue;
     }
   if(tradeManager_UseSPBands_)
     {
      return _isFalse;
     }
   return _isFalse;
  }

/*
  Chooses between defined take profit orders, Risk to reward & stop trailer
*/
/*
*  Function: tradeManagerRiskDefinedStopOrder(
                           ...
*  Function returns true for defined stop orders and false for Super Trend as Stop Orders
*/
uint tradeManagerProfitApplication(bool tradeManager_UseDefinedTakeProfitOrder_,
                                   bool tradeManager_UseDefinedRiskToReward_,
                                   bool tradeManager_UseStopTrailer_)
  {
   int _conditionCounter = 0;
   int _UseDefinedTakeProfitOrder = 0;
   int _UseDefinedRiskToReward = 0;
   int _UseStopTrailer = 0;

   if(tradeManager_UseDefinedTakeProfitOrder_)
     {
      _conditionCounter++;
      _UseDefinedTakeProfitOrder++;
     }
   if(tradeManager_UseDefinedRiskToReward_)
     {
      _conditionCounter++;
      _UseDefinedRiskToReward++;
     }
   if(tradeManager_UseStopTrailer_)
     {
      _conditionCounter++;
      _UseStopTrailer++;
     }

   if(_conditionCounter == 0 || _conditionCounter > 1)
     {
      return 0;
     }

   if(_UseDefinedTakeProfitOrder)
     {
      return 1;
     }
   if(_UseDefinedRiskToReward)
     {
      return 2;
     }
   if(_UseStopTrailer)
     {
      return 3;
     }

   return 0;
  }
/*
  Simplifies placing stop loss
*/
/*
*  Function: tradeManagerRiskStopManager(
                           ...
*  Function modifiy stop loss order
*/
void tradeManagerRiskStopManager(ulong ticket_,
                                 double stopLossPrice_)
  {
   double _stopLossPrice = convertPipsToPrice(stopLossPrice_);

   modifyStopLoss(ticket_, _stopLossPrice);
  }
//+------------------------------------------------------------------+

/*
   Return true when gain information is properly defined
*/
/*
*  Function: tradeManagerDefinedGainInitialization(bool tradeManager_SignalDefinedTakeProfit_,
                                           double tradeManager_SignalDefinedTakeProfitInPips_,
                                           bool tradeManager_SignalRiskToReward_,
                                           double tradeManager_WeakSignalRiskToRewardRatio_,
                                           bool tradeManager_SignalStopTrailer_,
                                           double tradeManager_WeakSignalBreakEvenAfterPriceCrossEntryInPips_,
                                           double tradeManager_WeakSignalTrailStopEveryNNumberOfPips_,
                                           string& tradeManager_SignalGainType_)
*  Function checks if the profit taking parameters are met otherwise it will reuturn false.
*/
bool tradeManagerDefinedGainInitialization(bool tradeManager_SignalDefinedTakeProfit_,
      double tradeManager_SignalDefinedTakeProfitInPips_,
      bool tradeManager_SignalRiskToReward_,
      double tradeManager_WeakSignalRiskToRewardRatio_,
      bool tradeManager_SignalStopTrailer_,
      double tradeManager_WeakSignalBreakEvenAfterPriceCrossEntryInPips_,
      double tradeManager_WeakSignalTrailStopEveryNNumberOfPips_,
      string& tradeManager_SignalGainType_)
  {
   bool _isFalse = false;
   bool _isTrue = true;

   if((!tradeManager_SignalDefinedTakeProfit_ &&
       !tradeManager_SignalRiskToReward_ &&
       !tradeManager_SignalStopTrailer_) ||
      (tradeManager_SignalDefinedTakeProfit_ &&
       tradeManager_SignalRiskToReward_ &&
       tradeManager_SignalStopTrailer_))
     {
      Print("User did not select one type of of profit taking option.");
      return _isFalse;
     }

   if(tradeManager_SignalDefinedTakeProfit_)
     {
      if(tradeManager_SignalDefinedTakeProfitInPips_ < 3)
        {
         Print("User opted to use defined take profit however did not apply applicable take profit value in pips." + DoubleToString(tradeManager_SignalDefinedTakeProfitInPips_));
         return _isFalse;
        }
      tradeManager_SignalGainType_ = "DefinedTakeProfit";
      return _isTrue;
     }
   if(tradeManager_SignalRiskToReward_)
     {
      if(tradeManager_WeakSignalRiskToRewardRatio_ < 1)
        {
         Print("User opted to use defined risk to reward ratio however did not apply applicable risk to reward ratio value in decimals.");
         return _isFalse;
        }
      tradeManager_SignalGainType_ = "RiskToRewardRatio";
      return _isTrue;
     }
   if(tradeManager_SignalStopTrailer_)
     {
      if(tradeManager_WeakSignalBreakEvenAfterPriceCrossEntryInPips_ < 1)
        {
         Print("User opted to use defined stop trailer however did not apply applicable break even value in in pips.");
         return _isFalse;
        }
      if(tradeManager_WeakSignalTrailStopEveryNNumberOfPips_ < 1)
        {
         Print("User opted to use defined stop trailer however did not apply applicable stop trailer value in in pips.");
         return _isFalse;
        }
      tradeManager_SignalGainType_ = "StopTrailer";
      return _isTrue;
     }

   Print("An error occured please select restart the EA or select different risk parameters.");
   return _isFalse;
  }
/*
   Return true when risk information is properly defined
*/
/*
*  Function: tradeManagerDefinedRiskInitialization(bool tradeManager_SignalUseDefinedStop_
                                                   double tradeManager_SignalDefinedStopInPips)
*  Function checks if the signal type is true, defined number of pips is true and pips are set accordingly
*  otherwise the function will return false also set Signal Risk Type to a defined value.
*/
bool tradeManagerDefinedRiskInitialization(bool tradeManager_SignalUseDefinedStop_,
      double tradeManager_SignalDefinedStopInPips,
      string& tradeManager_SignalRiskType_)
  {
   bool _isFalse = false;
   bool _isTrue = true;

   if(tradeManager_SignalUseDefinedStop_)
     {
      if(tradeManager_SignalDefinedStopInPips < 3)
        {
         Print("User opted to use defined stop loss however did not apply applicable stop loss value in pips.");
         return _isFalse;
        }
      tradeManager_SignalRiskType_ = "DefinedRisk";
      return _isTrue;
     }

   tradeManager_SignalRiskType_ = "UseBandsAsRisk";
   return _isTrue;
  }

/*
   Checks if risk and gain parameters are properly defined and prints hte information on the chart
*/
/*
*  Function: tradeManagerSignalInitialization(bool tradeManager_TradeSignalType_,
                                        bool tradeManager_SignalUseDefinedStop_,
                                        bool tradeManager_SignalDefinedTakeProfit,
                                        bool tradeManager_SignalRiskToReward,
                                        bool tradeManager_SignalStopTrailer,
                                        double tradeManager_SignalDefinedStopInPips_,
                                        double tradeManager_SignalDefinedTakeProfitInPips,
                                        double tradeManager_SignalBreakEvenAfterPriceCrossEntryInPips,
                                        double tradeManager_SignalTrailStopEveryNNumberOfPips,
                                        double tradeManager_SignalRiskToRewardRatio,
                                        string& tradeManager_SignalRiskType,
                                        string tradeManager_SignalType,
                                        string& tradeManager_SignalGainType_)
*  Function checks if risk and gain parameters if they are properly defined
*/
string tradeManagerSignalInitialization(bool tradeManager_TradeSignalType_,
                                        bool tradeManager_SignalUseDefinedStop_,
                                        bool tradeManager_SignalDefinedTakeProfit,
                                        bool tradeManager_SignalRiskToReward,
                                        bool tradeManager_SignalStopTrailer,
                                        double tradeManager_SignalDefinedStopInPips_,
                                        double tradeManager_SignalDefinedTakeProfitInPips,
                                        double tradeManager_SignalBreakEvenAfterPriceCrossEntryInPips,
                                        double tradeManager_SignalTrailStopEveryNNumberOfPips,
                                        double tradeManager_SignalRiskToRewardRatio,
                                        string& tradeManager_SignalRiskType,
                                        string tradeManager_SignalType,
                                        string& tradeManager_SignalGainType_)
  {
   bool _tradeManagerSignalDefinedGainInitialization;
   bool _tradeManagerSignalDefinedRiskInitialization = tradeManagerDefinedRiskInitialization(tradeManager_SignalUseDefinedStop_,
         tradeManager_SignalDefinedStopInPips_,
         tradeManager_SignalRiskType);

   if(!_tradeManagerSignalDefinedRiskInitialization)
     {
      return tradeManager_SignalType + " Risk Parameters are not properly defined, please restart the EA or define the parameters under EA Properties correctly.";
     }

   if(tradeManager_TradeSignalType_)
     {
      _tradeManagerSignalDefinedGainInitialization = tradeManagerDefinedGainInitialization(tradeManager_SignalDefinedTakeProfit,
            tradeManager_SignalDefinedTakeProfitInPips,
            tradeManager_SignalRiskToReward,
            tradeManager_SignalRiskToRewardRatio,
            tradeManager_SignalStopTrailer,
            tradeManager_SignalBreakEvenAfterPriceCrossEntryInPips,
            tradeManager_SignalTrailStopEveryNNumberOfPips,
            tradeManager_SignalGainType_);
      if(!_tradeManagerSignalDefinedGainInitialization)
        {
         return tradeManager_SignalType + " Gain Parameters are not properly defined, please restart the EA or define the parameters under EA Properties correctly.";
        }
     }

   if(tradeManager_SignalType == "Weak Signal")
     {
      drawText(ChartID(),
               "Signal Type: Weak Signal",
               "Signal Type: Weak " + (tradeManager_TradeSignalType_ ? "Activated - Gain type: " + tradeManager_SignalGainType_ : "N/A"),
               25, 40,
               CORNER_LEFT_UPPER,
               6,
               clrYellow,
               ANCHOR_LEFT_UPPER);
     }
   if(tradeManager_SignalType == "Moderate Signal")
     {
      drawText(ChartID(),
               "Signal Type: Moderate Signal",
               "Signal Type: Moderate " + (tradeManager_TradeSignalType_ ? "Activated - Gain type: " + tradeManager_SignalGainType_ : "N/A"),
               25, 60,
               CORNER_LEFT_UPPER,
               6,
               clrYellow,
               ANCHOR_LEFT_UPPER);
     }
   if(tradeManager_SignalType == "Strong Signal")
     {
      drawText(ChartID(),
               "Signal Type: Strong Signal",
               "Signal Type: Strong " + (tradeManager_TradeSignalType_ ? "Activated - Gain type: " + tradeManager_SignalGainType_ : "N/A"),
               25, 80,
               CORNER_LEFT_UPPER,
               6,
               clrYellow,
               ANCHOR_LEFT_UPPER);
     }

   return NULL;
  }

/*
   Return MqlTradeResults after opening a buy position based on given parameters
*/
/*
*  MqlTradeResult TradeManager_BuyOrder(string TradeManager_SignalRiskType_,
                           string TradeManager_SignalGainType_,
                           double TradeManager_SignalDefinedStopInPips_,
                           double SuperTrendBand_,
                           double SuperTrendSmoothing_,
                           double TradeManager_SignalDefinedTakeProfitInPips_,
                           double TradeManager_SignalRiskToRewardRatio,
                           double TradeManager_SignalBreakEvenAfterPriceCrossEntryInPips_,
                           double TradeManager_SignalTrailStopEveryNNumberOfPips_,
                           double TradeManager_SignalLotSize
*  Function open positions based on give risk and gain parameters.
*/
MqlTradeResult TradeManager_BuyOrder(string TradeManager_SignalRiskType_,
                                     string TradeManager_SignalGainType_,
                                     double TradeManager_SignalDefinedStopInPips_,
                                     double SuperTrendBand_,
                                     double SuperTrendSmoothing_,
                                     double TradeManager_SignalDefinedTakeProfitInPips_,
                                     double TradeManager_SignalRiskToRewardRatio,
                                     double TradeManager_SignalBreakEvenAfterPriceCrossEntryInPips_,
                                     double TradeManager_SignalTrailStopEveryNNumberOfPips_,
                                     double TradeManager_SignalLotSize)
  {
   string _riskType_DefinedRisk = "DefinedRisk";
   string _riskType_UseBandsAsRisk = "UseBandsAsRisk";
   string _gainType_DefinedTakeProfit = "DefinedTakeProfit";
   string _gainType_RiskToRewardRatio = "RiskToRewardRatio";
   string _gainType_StopTrailer = "StopTrailer";

   bool _isFalse = false;
   bool _isTrue = true;

   double _superTrendBand = SuperTrendBand_ + (SuperTrendSmoothing_ > 0 ? convertPipsToPrice(SuperTrendSmoothing_) : 0);

   MqlTradeResult _tradeResults;

   if(_riskType_DefinedRisk == TradeManager_SignalRiskType_)
     {
      if(_gainType_DefinedTakeProfit == TradeManager_SignalGainType_)
        {
         _tradeResults = openBuyOrder(Symbol(),
                                      TradeManager_SignalLotSize,
                                      TradeManager_SignalDefinedStopInPips_,
                                      _isFalse,
                                      TradeManager_SignalDefinedTakeProfitInPips_,
                                      _isFalse
                                     );
         return _tradeResults;
        }

      if(_gainType_RiskToRewardRatio == TradeManager_SignalGainType_)
        {
         double _riskToReward_Profit = TradeManager_SignalDefinedStopInPips_ * TradeManager_SignalRiskToRewardRatio;

         _tradeResults = openBuyOrder(Symbol(),
                                      TradeManager_SignalLotSize,
                                      TradeManager_SignalDefinedStopInPips_,
                                      _isFalse,
                                      _riskToReward_Profit,
                                      _isFalse
                                     );
         return _tradeResults;
        }

      if(_gainType_StopTrailer == TradeManager_SignalGainType_)
        {
         _tradeResults = openBuyOrder(Symbol(),
                                      TradeManager_SignalLotSize,
                                      TradeManager_SignalBreakEvenAfterPriceCrossEntryInPips_,
                                      _isFalse,
                                      NULL,
                                      _isFalse
                                     );
         return _tradeResults;
        }
     }
// === Use SuperTrend band as Risk
   if(_riskType_UseBandsAsRisk == TradeManager_SignalRiskType_)
     {
      if(_gainType_DefinedTakeProfit == TradeManager_SignalGainType_)
        {
         _tradeResults = openBuyOrder(Symbol(),
                                      TradeManager_SignalLotSize,
                                      _superTrendBand,
                                      _isTrue,
                                      TradeManager_SignalDefinedTakeProfitInPips_,
                                      _isFalse
                                     );
         return _tradeResults;
        }

      if(_gainType_RiskToRewardRatio == TradeManager_SignalGainType_)
        {

         double _riskToReward_Profit = (SymbolInfoDouble(Symbol(), SYMBOL_BID) + ((SymbolInfoDouble(Symbol(), SYMBOL_BID) - SuperTrendBand_) * TradeManager_SignalRiskToRewardRatio));
         Print("Hello TP -----------:", _riskToReward_Profit);

         _tradeResults = openBuyOrder(Symbol(),
                                      TradeManager_SignalLotSize,
                                      _superTrendBand,
                                      _isTrue,
                                      _riskToReward_Profit,
                                      _isTrue
                                     );
         return _tradeResults;
        }

      if(_gainType_StopTrailer == TradeManager_SignalGainType_)
        {
         _tradeResults = openBuyOrder(Symbol(),
                                      TradeManager_SignalLotSize,
                                      _superTrendBand,
                                      _isTrue,
                                      NULL,
                                      _isFalse
                                     );
         return _tradeResults;
        }
     }

   return _tradeResults;
  }
/*
   Return MqlTradeResults after opening a sell position based on given parameters
*/
/*
*  MqlTradeResult TradeManager_SellOrder(string TradeManager_SignalRiskType_,
                           string TradeManager_SignalGainType_,
                           double TradeManager_SignalDefinedStopInPips_,
                           double SuperTrendBand_,
                           double SuperTrendSmoothing_,
                           double TradeManager_SignalDefinedTakeProfitInPips_,
                           double TradeManager_SignalRiskToRewardRatio,
                           double TradeManager_SignalBreakEvenAfterPriceCrossEntryInPips_,
                           double TradeManager_SignalTrailStopEveryNNumberOfPips_,
                           double TradeManager_SignalLotSize
*  Function open positions based on give risk and gain parameters.
*/
MqlTradeResult TradeManager_SellOrder(string TradeManager_SignalRiskType_,
                                      string TradeManager_SignalGainType_,
                                      double TradeManager_SignalDefinedStopInPips_,
                                      double SuperTrendBand_,
                                      double SuperTrendSmoothing_,
                                      double TradeManager_SignalDefinedTakeProfitInPips_,
                                      double TradeManager_SignalRiskToRewardRatio,
                                      double TradeManager_SignalBreakEvenAfterPriceCrossEntryInPips_,
                                      double TradeManager_SignalTrailStopEveryNNumberOfPips_,
                                      double TradeManager_SignalLotSize)
  {
   string _riskType_DefinedRisk = "DefinedRisk";
   string _riskType_UseBandsAsRisk = "UseBandsAsRisk";
   string _gainType_DefinedTakeProfit = "DefinedTakeProfit";
   string _gainType_RiskToRewardRatio = "RiskToRewardRatio";
   string _gainType_StopTrailer = "StopTrailer";

   bool _isFalse = false;
   bool _isTrue = true;

   double _superTrendBand = SuperTrendBand_ + (SuperTrendSmoothing_ > 0 ? convertPipsToPrice(SuperTrendSmoothing_) : 0);

   MqlTradeResult _tradeResults;

   if(_riskType_DefinedRisk == TradeManager_SignalRiskType_)
     {
      if(_gainType_DefinedTakeProfit == TradeManager_SignalGainType_)
        {
         _tradeResults = openSellOrder(Symbol(),
                                       TradeManager_SignalLotSize,
                                       TradeManager_SignalDefinedStopInPips_,
                                       _isFalse,
                                       TradeManager_SignalDefinedTakeProfitInPips_,
                                       _isFalse
                                      );
         return _tradeResults;
        }

      if(_gainType_RiskToRewardRatio == TradeManager_SignalGainType_)
        {
         double _riskToReward_Profit = TradeManager_SignalDefinedStopInPips_ * TradeManager_SignalRiskToRewardRatio;

         _tradeResults = openSellOrder(Symbol(),
                                       TradeManager_SignalLotSize,
                                       TradeManager_SignalDefinedStopInPips_,
                                       _isFalse,
                                       _riskToReward_Profit,
                                       _isFalse
                                      );
         return _tradeResults;
        }

      if(_gainType_StopTrailer == TradeManager_SignalGainType_)
        {
         _tradeResults = openSellOrder(Symbol(),
                                       TradeManager_SignalLotSize,
                                       TradeManager_SignalBreakEvenAfterPriceCrossEntryInPips_,
                                       _isFalse,
                                       NULL,
                                       _isFalse
                                      );
         return _tradeResults;
        }
     }
// === Use SuperTrend band as Risk
   if(_riskType_UseBandsAsRisk == TradeManager_SignalRiskType_)
     {
      if(_gainType_DefinedTakeProfit == TradeManager_SignalGainType_)
        {
         _tradeResults = openSellOrder(Symbol(),
                                       TradeManager_SignalLotSize,
                                       _superTrendBand,
                                       _isTrue,
                                       TradeManager_SignalDefinedTakeProfitInPips_,
                                       _isFalse
                                      );
         return _tradeResults;
        }

      if(_gainType_RiskToRewardRatio == TradeManager_SignalGainType_)
        {
         double _riskToReward_Profit = (SymbolInfoDouble(Symbol(), SYMBOL_BID) - (SymbolInfoDouble(Symbol(), SYMBOL_BID) - convertPipsToPrice(TradeManager_SignalDefinedStopInPips_))) * TradeManager_SignalRiskToRewardRatio;

         _tradeResults = openSellOrder(Symbol(),
                                       TradeManager_SignalLotSize,
                                       _superTrendBand,
                                       _isTrue,
                                       _riskToReward_Profit,
                                       _isFalse
                                      );
         return _tradeResults;
        }

      if(_gainType_StopTrailer == TradeManager_SignalGainType_)
        {
         _tradeResults = openSellOrder(Symbol(),
                                       TradeManager_SignalLotSize,
                                       _superTrendBand,
                                       _isTrue,
                                       NULL,
                                       _isFalse
                                      );
         return _tradeResults;
        }
     }

   return _tradeResults;
  }

/*
   Return an error if the given parameters do not meet the condition
*/
/*
*  tradeManagerStopTrailerParamChacker(double tradeManager_SignalTrailStopEveryNNumberOfPips,
                                          double tradeManager_SignalTrailStopByNNumberofPips)
*  Function checks the given stop trailing parameters to determine if they are in order otherwise it returns an alert to notify the user about the error.
*/ 
 string tradeManagerStopTrailerParamChacker(double tradeManager_SignalTrailStopEveryNNumberOfPips,
                                          double tradeManager_SignalTrailStopByNNumberofPips,
                                          bool tradeManager_SignalStopTrailer)
{
   if ((tradeManager_SignalTrailStopByNNumberofPips >= tradeManager_SignalTrailStopEveryNNumberOfPips) &&
      tradeManager_SignalStopTrailer)
   {
      return "Trail stop by " + DoubleToString(tradeManager_SignalTrailStopByNNumberofPips) + 
             " pips input is greater than Trail stop every " + 
             DoubleToString(tradeManager_SignalTrailStopEveryNNumberOfPips) + 
             " pips. The former should be less and the latter should be greater";
   }
   
   return NULL;
}

//+------------------------------------------------------------------+
