//+------------------------------------------------------------------+
//|                                                MwilasBulletproof |
//|                                                         gmakhobe |
//|                   https://github.com/gmakhobe/mwilasfullproof_v2 |
//+------------------------------------------------------------------+
#include <Controls/Dialog.mqh>
#include <Controls/Button.mqh>
#include <Controls/Label.mqh>
#include <Controls/Picture.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (15)      // indent from left (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_Y                      (7)       // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (10)      // size by Y coordinate
//--- for group controls
#define GROUP_WIDTH                         (150)     // size by X coordinate
#define LIST_HEIGHT                         (179)     // size by Y coordinate
#define RADIO_HEIGHT                        (56)      // size by Y coordinate
#define CHECK_HEIGHT                        (93)      // size by Y coordinate
//-- for fonts
#define HEADING_SIZE                        (15)      // Text heading size
//-- for Stat-up info subtext
#define STARTUP_INFO_INDENT_SUBTEXT         (13)
//-- Trend info
#define TREND_INFO_INDENT_LABEL             (10)
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
private:
   CLabel            clabel_static_lowertimeframe_heading;
   CLabel            clabel_static_lowertimeframe_property_direction;
   CLabel            clabel_static_highertimeframe_heading;
   CLabel            clabel_static_highertimeframe_property_direction;
   
   CLabel            topic_actions;
   CLabel            heading_switch;
   CLabel            heading_automated_action;
   CLabel            topic_startup_info;
   CLabel            heading_start_trading_time;
   CLabel            heading_end_trading_time;
   CLabel            heading_risk;
   CLabel            heading_risk_to_reward_ratio;
   CLabel            sub_heading_start_trading_time;
   CLabel            sub_heading_end_trading_time;
   CLabel            sub_heading_risk;
   CLabel            sub_heading_risk_to_reward_ratio;
   CLabel            heading_higher_supported_pairs;
   
   CButton           button_static_on_auto_trade;
   CButton           button_dynamic_on_auto_trade;
   CButton           button_dynamic_on_break_even;
   CButton           button_execute_on_open_trade;
   CButton           button_execute_on_close_trades;
   
   CPicture          cpicture_lowertimeframe_direction;
   CPicture          cpicture_highertimeframe_direction;
   
   CLabel            clabel_dynamic_lowertimeframe_value_forproperty_direction;
   CLabel            clabel_dynamic_highertimeframe_value_forproperty_direction;
   
   CButton           m_button2;                       // the button object
   CButton           m_button3;                       // the fixed button object
   CButton           m_button1;
   
   bool              previous_condition_cpicture_lowertimeframe_direction;
   bool              initialy_executed_cpicture_lowertimeframe_direction;
   bool              previous_condition_picture_arrow_ltf_sp;
   bool              initialy_executed_picture_arrow_ltf_sp;
   bool              previous_condition_cpicture_highertimeframe_direction;
   bool              initialy_executed_cpicture_highertimeframe_direction;
   bool              previous_condition_picture_arrow_htf_sp;
   bool              initialy_executed_picture_arrow_htf_sp;

public:
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   virtual void      SetStartUpValues(const string startTradingTime, const string endTradingTime, const string risk, const string riskToRewardRatio);
   //--- Getters
   virtual bool      GetSwitchAutoTradeStatus(void);
   virtual bool      GetDynamicBreakEvenStatus(void);
   virtual bool      GetDynamicAutoTradeStatus(void);
   virtual bool      GetExecutionCanOpenTradeStatus(void);
   virtual bool      GetExecutionCanCloseTradesStatus(void);
   //--- Setters
   virtual void      SetDynamicAutoTradeStatus(bool status);
   virtual void      SetExecutionCanOpenTradeStatus(bool status);
   virtual void      SetExecutionCanCloseTradesStatus(bool status);
   virtual void      SetStaticAutoTradeStatus(bool status);
   // Update
   virtual void      onUpdateCPictureHigherTimeframe(bool isUpTrend, bool isDownTrend);
   virtual void      onUpdateCPictureLowerTimeframe(bool isUpTrend, bool isDownTrend);
   virtual void      onUpdateCLabelDynamicLowerTimeframeValue_forProperty_Direction(bool isUpTrend, bool isDownTrend);
   virtual void      onUpdateCLabelDynamicHigherTimeframeValue_forProperty_Direction(bool isUpTrend, bool isDownTrend);

protected:
   //--- create dependent controls
   bool              onCreateCLabelStaticLowerTimeframeHeading(void);
   bool              onCreateCLabelStaticLowerTimeframeProperty_Direction(void);
   bool              onCreateCLabelStaticHigherTimeframeHeading(void);
   bool              onCreateCLabelStaticHigherTimeframeProperty_Direction(void);
   
   bool              CreateTopicActions(void);
   bool              CreateHeadingSwitch(void);
   bool              CreateHeadingAutomatedAction(void);
   bool              CreateTopicStartUpInfo(void);
   bool              CreateHeadingStartTradingTime(void);
   bool              CreateHeadingEndTradingTime(void);
   bool              CreateHeadingRisk(void);
   bool              CreateHeadingRiskRewardRation(void);
   bool              CreateSubHeadingStartTradingTime(void);
   bool              CreateSubHeadingEndTradingTime(void);
   bool              CreateSubHeadingRisk(void);
   bool              CreateSubHeadingRiskRewardRation(void);
   bool              CreateHeadingSupported(void);
   bool              CreateCLabels(void);
   bool              CreateCButtons(void);
   bool              CreateCPictures(void);
   bool              CreateButton1(void);
   bool              CreateButton2(void);
   bool              CreateButton3(void);
   bool              CreateButtonStaticOptionAutoTrade(void);
   bool              CreateButtonDynamicOptionAutoTrade(void);
   bool              CreateButtonDynamicOptionBreakEven(void);
   bool              CreateButtonExecuteOptionCloseTrades(void);
   bool              CreateButtonExecuteOptionOpenTrade(void);
   bool              onCreateCPictureLowerTimeframeInit(void);
   bool              onCreateCPictureHigherTimeframeInit(void);
   bool              onCreateCLabelDynamicLowerTimeframeValue_forProperty_Direction(void);
   bool              onCreateCLabelDynamicHigherTimeframeValue_forProperty_Direction(void);
   //--- My fuctions
   void              SetPanelProperties(void);
   //--- Event Handlers
   void              onSwitchAutoTradeOnOrOff(void);
   void              onDynamicAutoTradeOnOrOff(void);
   void              onDynamicBreakEvenOnOrOff(void);
   void              onExecuteOpenTrade(void);
   void              onExecuteCloseTrades(void);
   //--- Event Handler Callback
   void              changeSwitchAutoTradeButtonOnOrOff(void);
   void              changeDynamicAutoTradeButtonOnOrOff(void);
   void              changeDynamicBreakEvenButtonOnOrOff(void);
   void              changeExecuteOpenTrade(void);
   void              changeExecuteCloseTrades(void);
   bool              switchCanAutoTrade;
   bool              dynamicCanAutoTrade;
   bool              dynamicCanBreakEven;
   bool              executeCanOpenTrade;
   bool              executeCanCloseTrades;

   int               INDENT_TOP;// indent from top (with allowance for border width)
   int               INDENT_RIGHT;// indent from right (with allowance for border width)
   int               CONTROLS_GAP_X;// gap by X coordinate
  };

EVENT_MAP_BEGIN(CControlsDialog)
ON_EVENT(ON_CLICK, button_static_on_auto_trade, onSwitchAutoTradeOnOrOff)
ON_EVENT(ON_CLICK, button_dynamic_on_auto_trade, onDynamicAutoTradeOnOrOff)
ON_EVENT(ON_CLICK, button_dynamic_on_break_even, onDynamicBreakEvenOnOrOff)
ON_EVENT(ON_CLICK, button_execute_on_open_trade, onExecuteOpenTrade)
ON_EVENT(ON_CLICK, button_execute_on_close_trades, onExecuteCloseTrades)
EVENT_MAP_END(CAppDialog)

CControlsDialog::CControlsDialog(void)
  {
   switchCanAutoTrade = false;
   dynamicCanAutoTrade = false;
   executeCanOpenTrade = false;
   executeCanCloseTrades = false;
   dynamicCanBreakEven = true;
   INDENT_RIGHT = 12;
   INDENT_TOP = 15;
   CONTROLS_GAP_X = 8;
   initialy_executed_cpicture_lowertimeframe_direction = false;
   initialy_executed_picture_arrow_ltf_sp = false;
   initialy_executed_cpicture_highertimeframe_direction = false;
   initialy_executed_picture_arrow_htf_sp = false;
  }

CControlsDialog::~CControlsDialog(void)
  {
  }

bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
    if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
     {
      return(false);
     }
    /*
      Create all labels/Text
    */
    if(!CreateCLabels())
     {
      return(false);
     }
    /*
      Create all Pictures
    */
   if(!CreateCPictures())
     {
      return(false);
     }
   if(!CreateCButtons())
     {
      return(false);
     }

   SetPanelProperties();
   return(true);
  }

/**
 * 
 * 
 *  Start: Create labels/texts
 * 
 * 
*/

bool CControlsDialog::CreateCLabels(void)
  {
   if(!onCreateCLabelStaticLowerTimeframeHeading())
     {
      return(false);
     }
   if(!onCreateCLabelStaticLowerTimeframeProperty_Direction())
     {
      return(false);
     }
   if(!onCreateCLabelDynamicLowerTimeframeValue_forProperty_Direction())
     {
      return(false);
     }
   if(!onCreateCLabelStaticHigherTimeframeHeading())
     {
      return(false);
     }
   if(!onCreateCLabelStaticHigherTimeframeProperty_Direction())
     {
      return(false);
     }
   if(!onCreateCLabelDynamicHigherTimeframeValue_forProperty_Direction())
     {
      return(false);
     }
   if(!CreateTopicActions())
     {
      return(false);
     }
   if(!CreateHeadingSwitch())
     {
      return(false);
     }
   if(!CreateHeadingAutomatedAction())
     {
      return(false);
     }
   if(!CreateTopicStartUpInfo())
     {
      return(false);
     }
   if(!CreateHeadingStartTradingTime())
     {
      return(false);
     }
   if(!CreateHeadingEndTradingTime())
     {
      return(false);
     }
   if(!CreateHeadingRisk())
     {
      return(false);
     }
   if(!CreateHeadingRiskRewardRation())
     {
      return(false);
     }
   if(!CreateSubHeadingStartTradingTime())
     {
      return(false);
     }
   if(!CreateSubHeadingEndTradingTime())
     {
      return(false);
     }
   if(!CreateSubHeadingRisk())
     {
      return(false);
     }
   if(!CreateSubHeadingRiskRewardRation())
     {
      return(false);
     }
   if(!CreateHeadingSupported())
     {
      return(false);
     }

   return true;
  }

//-- Start: Lower Timeframe Labels

bool CControlsDialog::onCreateCLabelStaticLowerTimeframeHeading(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT;
   int y1 = INDENT_TOP+CONTROLS_GAP_Y;
   int x2 = x1 + 100;
   int y2= y1 + 20;

   if(!clabel_static_lowertimeframe_heading.Create(m_chart_id, m_name + "clabel_static_lowertimeframe_heading", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!clabel_static_lowertimeframe_heading.Text("Lower Timeframe:"))
     {
      return(false);
     }
   if(!clabel_static_lowertimeframe_heading.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(clabel_static_lowertimeframe_heading))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::onCreateCLabelStaticLowerTimeframeProperty_Direction(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 5);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!clabel_static_lowertimeframe_property_direction.Create(m_chart_id, m_name + "clabel_static_lowertimeframe_property_direction", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!clabel_static_lowertimeframe_property_direction.Text("Direction: "))
     {
      return(false);
     }
   if(!clabel_static_lowertimeframe_property_direction.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(clabel_static_lowertimeframe_property_direction))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::onCreateCLabelDynamicLowerTimeframeValue_forProperty_Direction(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * TREND_INFO_INDENT_LABEL;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 5);
   int x2 = x1 + 100;
   int y2= y1 + 20;

   if(!clabel_dynamic_lowertimeframe_value_forproperty_direction.Create(m_chart_id, m_name + "clabel_dynamic_lowertimeframe_value_forproperty_direction", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!clabel_dynamic_lowertimeframe_value_forproperty_direction.Text("loading..."))
     {
      return(false);
     }
   if(!clabel_dynamic_lowertimeframe_value_forproperty_direction.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(clabel_dynamic_lowertimeframe_value_forproperty_direction))
     {
      return(false);
     }
   return(true);
  }

//-- End: Lower Timeframe Labels
//-- Start: Higher Timeframe Labels

bool CControlsDialog::onCreateCLabelStaticHigherTimeframeHeading(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 11);
   int x2 = x1 + 100;
   int y2= y1 + 20;

   if(!clabel_static_highertimeframe_heading.Create(m_chart_id, m_name + "clabel_static_clabel_static_highertimeframe_heading", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!clabel_static_highertimeframe_heading.Text("Higher Timeframe:"))
     {
      return(false);
     }
   if(!clabel_static_highertimeframe_heading.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(clabel_static_highertimeframe_heading))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::onCreateCLabelStaticHigherTimeframeProperty_Direction(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 14);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   
   if(!clabel_static_highertimeframe_property_direction.Create(m_chart_id, m_name + "clabel_static_highertimeframe_property_direction", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!clabel_static_highertimeframe_property_direction.Text("Direction: "))
     {
      return(false);
     }
   if(!clabel_static_highertimeframe_property_direction.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(clabel_static_highertimeframe_property_direction))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::onCreateCLabelDynamicHigherTimeframeValue_forProperty_Direction(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * TREND_INFO_INDENT_LABEL;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 14);
   int x2 = x1 + 100;
   int y2= y1 + 20;

   if(!clabel_dynamic_highertimeframe_value_forproperty_direction.Create(m_chart_id, m_name + "clabel_dynamic_highertimeframe_value_forproperty_direction", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!clabel_dynamic_highertimeframe_value_forproperty_direction.Text("loading..."))
     {
      return(false);
     }
   if(!clabel_dynamic_highertimeframe_value_forproperty_direction.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(clabel_dynamic_highertimeframe_value_forproperty_direction))
     {
      return(false);
     }
   return(true);
  }

//-- End: Higher Timeframe Labels

/**
 * 
 * 
 *  End: Create labels/texts
 * 
 * 
*/
/**
 * 
 * 
 *  Start: Update labels/text
 * 
 * 
*/

//-- Start: Lower Timeframe Labels

void CControlsDialog::onUpdateCLabelDynamicLowerTimeframeValue_forProperty_Direction(bool isUpTrend, bool isDownTrend)
{
  if(isUpTrend == true && isDownTrend == false)
     {
      clabel_dynamic_highertimeframe_value_forproperty_direction.Text("Bullish");
      clabel_dynamic_highertimeframe_value_forproperty_direction.Color(clrGreen);
     }
  if (isUpTrend == false && isDownTrend == true)
      {
        clabel_dynamic_highertimeframe_value_forproperty_direction.Text("Bearish");
        clabel_dynamic_highertimeframe_value_forproperty_direction.Color(clrRed);
      }
}

//-- End: Lower Timeframe Labels
//-- Start: Higher Timeframe Labels

void CControlsDialog::onUpdateCLabelDynamicHigherTimeframeValue_forProperty_Direction(bool isUpTrend, bool isDownTrend)
{
  if(isUpTrend == true && isDownTrend == false)
     {
      clabel_dynamic_lowertimeframe_value_forproperty_direction.Text("Bullish");
      clabel_dynamic_lowertimeframe_value_forproperty_direction.Color(clrGreen);
     }
  if (isUpTrend == false && isDownTrend == true)
      {
        clabel_dynamic_lowertimeframe_value_forproperty_direction.Text("Bearish");
        clabel_dynamic_lowertimeframe_value_forproperty_direction.Color(clrRed);
      }
}

//-- End: Higher Timeframe Labels

/**
 * 
 * 
 *  End: Update labels/text
 * 
 * 
*/

/**
 * 
 * 
 *  Start: Create Pictures
 * 
 * 
*/

bool CControlsDialog::CreateCPictures(void)
  {
   if(!onCreateCPictureLowerTimeframeInit())
     {
      return(false);
     }
   if(!onCreateCPictureHigherTimeframeInit())
     {
      return(false);
     }
   return true;
  }

//-- Start: Lower Timeframe Pictures

bool CControlsDialog::onCreateCPictureLowerTimeframeInit(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 7;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 4);
   int x2= x1 + 32;
   int y2=y1 + 32;
//--- create
   if(!cpicture_lowertimeframe_direction.Create(m_chart_id,m_name+"cpicture_lowertimeframe_direction",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
//--- set the name of bmp files to display the CPicture control
   cpicture_lowertimeframe_direction.BmpName("\\Images\\forbidden.bmp");

   if(!Add(cpicture_lowertimeframe_direction))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

//-- End: Lower Timeframe Pictures
//-- Start: Higher Timeframe Pictures

bool CControlsDialog::onCreateCPictureHigherTimeframeInit(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 7;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 14);
   int x2=x1+32;
   int y2=y1+32;
//--- create
   if(!cpicture_highertimeframe_direction.Create(m_chart_id,m_name+"cpicture_highertimeframe_direction",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
//--- set the name of bmp files to display the CPicture control
   cpicture_highertimeframe_direction.BmpName("\\Images\\forbidden.bmp");

   if(!Add(cpicture_highertimeframe_direction))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

//-- End: Higher Timeframe Pictures

/**
 * 
 * 
 *  End: Create Pictures
 * 
 * 
*/
/**
 * 
 * 
 *  Start: Update Pictures
 * 
 * 
*/

//-- Start: Lower Timeframe Labels

void CControlsDialog::onUpdateCPictureLowerTimeframe(bool isUpTrend, bool isDownTrend)
{
  if(isUpTrend == true && isDownTrend == false)
  {
    cpicture_lowertimeframe_direction.BmpName("\\Images\\upmt5.bmp");
  }

  if(isUpTrend == false && isDownTrend == true)
  {
    cpicture_lowertimeframe_direction.BmpName("\\Images\\downmt5.bmp");
  }
}

//-- End: Lower Timeframe Labels
//-- Start: Higher Timeframe Labels

void CControlsDialog::onUpdateCPictureHigherTimeframe(bool isUpTrend, bool isDownTrend)
{
  if(isUpTrend == true && isDownTrend == false)
  {
    cpicture_highertimeframe_direction.BmpName("\\Images\\upmt5.bmp");
  }
  
  if(isUpTrend == false && isDownTrend == true)
  {
    cpicture_highertimeframe_direction.BmpName("\\Images\\downmt5.bmp");
  }
}

//-- End: Higher Timeframe Labels

/**
 * 
 * 
 *  End: Update Pictures
 * 
 * 
*/

bool CControlsDialog::CreateCButtons(void)
  {
   if(!CreateButtonStaticOptionAutoTrade())
     {
      return(false);
     }
   if(!CreateButtonDynamicOptionAutoTrade())
     {
      return(false);
     }
   if(!CreateButtonDynamicOptionBreakEven())
     {
      return(false);
     }
   if(!CreateButtonExecuteOptionCloseTrades())
     {
      return(false);
     }
   if(!CreateButtonExecuteOptionOpenTrade())
     {
      return(false);
     }

   changeSwitchAutoTradeButtonOnOrOff();
   return true;
  }

void CControlsDialog::SetStartUpValues(const string startTradingTime, const string endTradingTime, const string risk, const string riskToRewardRatio)
  {
   sub_heading_start_trading_time.Text(startTradingTime);
   sub_heading_end_trading_time.Text(endTradingTime);
   sub_heading_risk.Text(risk);
   sub_heading_risk_to_reward_ratio.Text(riskToRewardRatio);
  }

bool CControlsDialog::CreateTopicActions(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 10;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 20);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!topic_actions.Create(m_chart_id, m_name + "topic_actions", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!topic_actions.Text("Actions"))
     {
      return(false);
     }
   if(!topic_actions.FontSize(HEADING_SIZE))
     {
      return(false);
     }
   if(!topic_actions.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(topic_actions))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingSwitch(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 23);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_switch.Create(m_chart_id, m_name + "heading_switch", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_switch.Text("Switch: (Static & Execution)"))
     {
      return(false);
     }
   if(!heading_switch.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_switch))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingAutomatedAction(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 29);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_automated_action.Create(m_chart_id, m_name + "heading_automated_action", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_automated_action.Text("Automated Action: (Dynamic)"))
     {
      return(false);
     }
   if(!heading_automated_action.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_automated_action))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateTopicStartUpInfo(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 10;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 36);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!topic_startup_info.Create(m_chart_id, m_name + "topic_startup_info", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!topic_startup_info.Text("Start-Up Info"))
     {
      return(false);
     }
   if(!topic_startup_info.FontSize(HEADING_SIZE))
     {
      return(false);
     }
   if(!topic_startup_info.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(topic_startup_info))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingStartTradingTime(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 39);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_start_trading_time.Create(m_chart_id, m_name + "heading_start_trading_time", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_start_trading_time.Text("Start trading from: "))
     {
      return(false);
     }
   if(!heading_start_trading_time.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_start_trading_time))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingEndTradingTime(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 42);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_end_trading_time.Create(m_chart_id, m_name + "heading_end_trading_time", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_end_trading_time.Text("End trading at: "))
     {
      return(false);
     }
   if(!heading_end_trading_time.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_end_trading_time))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingRisk(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 45);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_risk.Create(m_chart_id, m_name + "heading_risk", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_risk.Text("Risk: "))
     {
      return(false);
     }
   if(!heading_risk.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_risk))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingRiskRewardRation(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 48);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_risk_to_reward_ratio.Create(m_chart_id, m_name + "heading_risk_to_reward_ratio", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_risk_to_reward_ratio.Text("Risk to reward ration: "))
     {
      return(false);
     }
   if(!heading_risk_to_reward_ratio.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_risk_to_reward_ratio))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateSubHeadingStartTradingTime(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * STARTUP_INFO_INDENT_SUBTEXT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 39);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!sub_heading_start_trading_time.Create(m_chart_id, m_name + "sub_heading_start_trading_time", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!sub_heading_start_trading_time.Text("loading..."))
     {
      return(false);
     }
   if(!sub_heading_start_trading_time.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(sub_heading_start_trading_time))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateSubHeadingEndTradingTime(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * STARTUP_INFO_INDENT_SUBTEXT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 42);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!sub_heading_end_trading_time.Create(m_chart_id, m_name + "sub_heading_end_trading_time", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!sub_heading_end_trading_time.Text("loading..."))
     {
      return(false);
     }
   if(!sub_heading_end_trading_time.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(sub_heading_end_trading_time))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateSubHeadingRisk(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * STARTUP_INFO_INDENT_SUBTEXT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 45);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!sub_heading_risk.Create(m_chart_id, m_name + "sub_heading_risk", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!sub_heading_risk.Text("loading..."))
     {
      return(false);
     }
   if(!sub_heading_risk.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(sub_heading_risk))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateSubHeadingRiskRewardRation(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * STARTUP_INFO_INDENT_SUBTEXT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 48);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!sub_heading_risk_to_reward_ratio.Create(m_chart_id, m_name + "sub_heading_risk_to_reward_ratio", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!sub_heading_risk_to_reward_ratio.Text("loading..."))
     {
      return(false);
     }
   if(!sub_heading_risk_to_reward_ratio.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(sub_heading_risk_to_reward_ratio))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateHeadingSupported(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 2;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 51);
   int x2 = x1 + 100;
   int y2= y1 + 20;
   int chart_id = 0;
   int sub_window = 0;

   if(!heading_higher_supported_pairs.Create(m_chart_id, m_name + "heading_higher_supported_pairs", m_subwin, x1, y1, x2, y2))
     {
      return(false);
     }
   if(!heading_higher_supported_pairs.Text("Supported Pairs: GBPJPY, USDJPY, GBPUSD"))
     {
      return(false);
     }
   if(!heading_higher_supported_pairs.Color(clrWhite))
     {
      return(false);
     }
   if(!Add(heading_higher_supported_pairs))
     {
      return(false);
     }
   return(true);
  }

bool CControlsDialog::CreateButtonStaticOptionAutoTrade(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 26);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!button_static_on_auto_trade.Create(m_chart_id,m_name+"button_static_on_auto_trade",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
   if(!button_static_on_auto_trade.Text("Auto Trade"))
     {
      return(false);
     }
   if(!button_static_on_auto_trade.Color(clrWhite))
     {
      return(false);
     }
   if(!button_static_on_auto_trade.ColorBackground(clrGreen))
     {
      return(false);
     }
   if(!Add(button_static_on_auto_trade))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

bool CControlsDialog::CreateButtonDynamicOptionAutoTrade(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 32);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!button_dynamic_on_auto_trade.Create(m_chart_id,m_name+"button_dynamic_on_auto_trade",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
   if(!button_dynamic_on_auto_trade.Text("Auto Trade - Off"))
     {
      return(false);
     }
   if(!button_dynamic_on_auto_trade.Color(clrWhite))
     {
      return(false);
     }
   if(!button_dynamic_on_auto_trade.ColorBackground(clrRed))
     {
      return(false);
     }
   if(!Add(button_dynamic_on_auto_trade))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

bool CControlsDialog::CreateButtonDynamicOptionBreakEven(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 12;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 32);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!button_dynamic_on_break_even.Create(m_chart_id,m_name+"button_dynamic_on_break_even",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
   if(!button_dynamic_on_break_even.Text("Break even - On"))
     {
      return(false);
     }
   if(!button_dynamic_on_break_even.Color(clrWhite))
     {
      return(false);
     }
   if(!button_dynamic_on_break_even.ColorBackground(clrGreen))
     {
      return(false);
     }
   if(!Add(button_dynamic_on_break_even))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

bool CControlsDialog::CreateButtonExecuteOptionCloseTrades(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 23;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 26);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!button_execute_on_close_trades.Create(m_chart_id,m_name+"button_execute_on_close_trades",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
   if(!button_execute_on_close_trades.Text("Close Trades"))
     {
      return(false);
     }
   if(!button_execute_on_close_trades.Color(clrBlack))
     {
      return(false);
     }
   if(!button_execute_on_close_trades.ColorBackground(clrWhite))
     {
      return(false);
     }
   if(!Add(button_execute_on_close_trades))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

bool CControlsDialog::CreateButtonExecuteOptionOpenTrade(void)
  {
//--- coordinates
   int x1 = INDENT_RIGHT * 12;
   int y1 = INDENT_TOP + (CONTROLS_GAP_Y * 26);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!button_execute_on_open_trade.Create(m_chart_id,m_name+"button_execute_on_open_trade",m_subwin,x1,y1,x2,y2))
     {
      return(false);
     }
   if(!button_execute_on_open_trade.Text("Open Trade"))
     {
      return(false);
     }
   if(!button_execute_on_open_trade.Color(clrBlack))
     {
      return(false);
     }
   if(!button_execute_on_open_trade.ColorBackground(clrWhite))
     {
      return(false);
     }
   if(!Add(button_execute_on_open_trade))
     {
      return(false);
     }
//--- succeed
   return(true);
  }

bool CControlsDialog::CreateButton2(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+2*(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button2.Create(m_chart_id,m_name+"Button2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button2.Text("Locked"))
      return(false);
   if(!Add(m_button2))
      return(false);
   m_button2.Locking(true);
//--- succeed
   return(true);
  }

bool CControlsDialog::CreateButton3(void)
  {
//--- coordinates
   int x1=INDENT_LEFT+2*(BUTTON_WIDTH+CONTROLS_GAP_X);
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button3.Create(m_chart_id,m_name+"Button3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button3.Text("Locked"))
      return(false);
   if(!Add(m_button3))
      return(false);
   m_button3.Locking(true);
//--- succeed
   return(true);
  }

void CControlsDialog::SetPanelProperties(void)
  {
   string prefix = Name();
   int total = InfoPanel.ControlsTotal();

   for(int i = 0; i< total; i++)
     {
      CWnd*obj = InfoPanel.Control(i);
      string name = obj.Name();
      //---
      if(name == prefix+"Client")
        {
         CWndClient *wndclient = (CWndClient*) obj;
         color clr = clrBlack;
         wndclient.ColorBackground(clr);
        }
      if(name==prefix+"Caption")
        {
         CEdit *edit=(CEdit*) obj;
         color clrBG= clrBlack;
         color clrText = clrWhite;
         edit.ColorBackground(clrBG);
         edit.Color(clrText);
        }
      if(name==prefix+"Border")
        {
         CPanel *panel=(CPanel*) obj;
         panel.ColorBackground(clrBlack);
         panel.ColorBorder(clrBlack);
        }
      ChartRedraw();
     }
  }

void CControlsDialog::onSwitchAutoTradeOnOrOff(void)
  {
   if(switchCanAutoTrade == true)
     {
      dynamicCanAutoTrade = true;
      onDynamicAutoTradeOnOrOff();
      switchCanAutoTrade = false;
      changeSwitchAutoTradeButtonOnOrOff();
      return ;
     }
   if(switchCanAutoTrade == false)
     {
      switchCanAutoTrade = true;
      changeSwitchAutoTradeButtonOnOrOff();
      return ;
     }
  }

void CControlsDialog::changeSwitchAutoTradeButtonOnOrOff(void)
  {
   if(switchCanAutoTrade == true)
     {
      button_static_on_auto_trade.Color(clrWhite);
      button_static_on_auto_trade.ColorBackground(clrGreen);
     }
   if(switchCanAutoTrade == false)
     {
      button_static_on_auto_trade.Color(clrWhite);
      button_static_on_auto_trade.ColorBackground(clrRed);
     }
   ChartRedraw();
  }

void CControlsDialog::onDynamicAutoTradeOnOrOff(void)
  {
   if(switchCanAutoTrade == true)
     {
      if(dynamicCanAutoTrade == true)
        {
         dynamicCanAutoTrade = false;
         changeDynamicAutoTradeButtonOnOrOff();
         return ;
        }
      if(dynamicCanAutoTrade == false)
        {
         dynamicCanAutoTrade = true;
         changeDynamicAutoTradeButtonOnOrOff();
         return ;
        }
     }
  }

void CControlsDialog::changeDynamicAutoTradeButtonOnOrOff(void)
  {
   if(dynamicCanAutoTrade == true)
     {
      button_dynamic_on_auto_trade.Color(clrWhite);
      button_dynamic_on_auto_trade.ColorBackground(clrGreen);
      button_dynamic_on_auto_trade.Text("Auto Trade - On");
     }
   if(dynamicCanAutoTrade == false)
     {
      button_dynamic_on_auto_trade.Color(clrWhite);
      button_dynamic_on_auto_trade.ColorBackground(clrRed);
      button_dynamic_on_auto_trade.Text("Auto Trade - Off");
     }
   ChartRedraw();
  }

void CControlsDialog::onDynamicBreakEvenOnOrOff(void)
  {
   if(dynamicCanBreakEven == true)
     {
      dynamicCanBreakEven = false;
      changeDynamicBreakEvenButtonOnOrOff();
      return ;
     }
   if(dynamicCanBreakEven == false)
     {
      dynamicCanBreakEven = true;
      changeDynamicBreakEvenButtonOnOrOff();
      return ;
     }
  }

void CControlsDialog::changeDynamicBreakEvenButtonOnOrOff(void)
  {
   if(dynamicCanBreakEven == true)
     {
      button_dynamic_on_break_even.Color(clrWhite);
      button_dynamic_on_break_even.ColorBackground(clrGreen);
      button_dynamic_on_break_even.Text("Break even - On");
     }
   if(dynamicCanBreakEven == false)
     {
      button_dynamic_on_break_even.Color(clrWhite);
      button_dynamic_on_break_even.ColorBackground(clrRed);
      button_dynamic_on_break_even.Text("Break even - Off");
     }
   ChartRedraw();
  }

void CControlsDialog::onExecuteOpenTrade(void)
  {
   if(executeCanOpenTrade == true)
     {
      executeCanOpenTrade = false;
      changeExecuteOpenTrade();
      return ;
     }
   if(executeCanOpenTrade == false)
     {
      executeCanOpenTrade = true;
      changeExecuteOpenTrade();
      return ;
     }
  }

void CControlsDialog::changeExecuteOpenTrade(void)
  {
   if(executeCanOpenTrade == true)
     {
      button_execute_on_open_trade.Color(clrWhite);
      button_execute_on_open_trade.ColorBackground(clrBlack);
      button_execute_on_open_trade.Text("Open Trade");
     }
   if(executeCanOpenTrade == false)
     {
      button_execute_on_open_trade.Color(clrBlack);
      button_execute_on_open_trade.ColorBackground(clrWhite);
      button_execute_on_open_trade.Text("Open Trade");
     }
   ChartRedraw();
  }

void CControlsDialog::onExecuteCloseTrades(void)
  {
   if(executeCanCloseTrades == true)
     {
      executeCanCloseTrades = false;
      changeExecuteCloseTrades();
      return ;
     }
   if(executeCanCloseTrades == false)
     {
      executeCanCloseTrades = true;
      changeExecuteCloseTrades();
      return ;
     }
  }

void CControlsDialog::changeExecuteCloseTrades(void)
  {
   if(executeCanCloseTrades == true)
     {
      button_execute_on_close_trades.Color(clrWhite);
      button_execute_on_close_trades.ColorBackground(clrBlack);
      button_execute_on_close_trades.Text("Close Trades");
     }
   if(executeCanCloseTrades == false)
     {
      button_execute_on_close_trades.Color(clrBlack);
      button_execute_on_close_trades.ColorBackground(clrWhite);
      button_execute_on_close_trades.Text("Close Trades");
     }
   ChartRedraw();
  }

//+------------------------------------------------------------------+
//| Getters and Setter                                                 |
//+------------------------------------------------------------------+
bool CControlsDialog::GetSwitchAutoTradeStatus(void)
  {
   return switchCanAutoTrade;
  }

bool CControlsDialog::GetDynamicBreakEvenStatus(void)
  {
   return dynamicCanBreakEven;
  }

bool CControlsDialog::GetDynamicAutoTradeStatus(void)
  {
   return dynamicCanAutoTrade;
  }

bool CControlsDialog::GetExecutionCanOpenTradeStatus(void)
  {
   return executeCanOpenTrade;
  }

bool CControlsDialog::GetExecutionCanCloseTradesStatus(void)
  {
   return executeCanCloseTrades;
  }
//-- Setters
void CControlsDialog::SetStaticAutoTradeStatus(bool status)
  {
    switchCanAutoTrade = status;

    changeSwitchAutoTradeButtonOnOrOff();
  }

void CControlsDialog::SetDynamicAutoTradeStatus(bool status)
  {
    dynamicCanAutoTrade = status;

    changeDynamicAutoTradeButtonOnOrOff();
  }

void CControlsDialog::SetExecutionCanOpenTradeStatus(bool status)
  {
   executeCanOpenTrade = status;
   changeExecuteOpenTrade();
  }

void CControlsDialog::SetExecutionCanCloseTradesStatus(bool status)
  {
   executeCanCloseTrades = status;
   changeExecuteCloseTrades();
  }

//CControlsDialog ExtDialog;
CControlsDialog InfoPanel;
//+------------------------------------------------------------------+
