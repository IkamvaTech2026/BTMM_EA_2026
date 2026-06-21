#ifndef __BTMM_DEFINES_MQH__
#define __BTMM_DEFINES_MQH__

#define BTMM_VERSION "2.0.0"

//--- Direction enum
enum ENUM_DIRECTION
{
   DIR_LONG = 1,
   DIR_SHORT = -1
};

//--- Setup types
enum ENUM_BTMM_SETUP
{
   SETUP_MW_LEG2 = 0,
   SETUP_TRADE_33 = 1,
   SETUP_NYC_REVERSAL = 2,
   SETUP_EMA200_BOUNCE = 3,
   SETUP_SWING = 4,
   SETUP_STRAIGHTAWAY = 5,
   SETUP_HALF_BATMAN = 6,
   SETUP_STOP_HUNT = 7
};

//--- Market levels
enum ENUM_MARKET_LEVEL
{
   LEVEL_CONSOLIDATION = 0,
   LEVEL_BREAKOUT = 1,
   LEVEL_PULLBACK = 2
};

//--- Intraday phases
enum ENUM_INTRADAY_PHASE
{
   PHASE_ASIA = 0,
   PHASE_LONDON = 1,
   PHASE_US_OPEN = 2,
   PHASE_US_SESSION = 3
};

//--- Trade Signal struct
struct STradeSignal
{
   bool valid;
   string symbol;
   int direction;
   ENUM_BTMM_SETUP setup_type;
   double entry;
   double stop_loss;
   double tp1;
   int confluence_score;
   string notes;
};

//--- Asian Range struct
struct SAsianRange
{
   bool valid;
   double high;
   double low;
   int range_pips;
};

//--- M/W Pattern struct
struct SMW_Pattern
{
   bool detected;
   int direction;
   double first_leg_size;
   double second_leg_size;
   double neckline;
   bool neckline_broken;
   int pattern_confidence;
   double symmetry_score;
   double structure_clarity;
   double breakout_strength;
   double displacement_quality;
};

//--- Stop Hunt struct
struct SStopHunt
{
   bool detected;
   int direction;
   int push_count;
   int distance_pips;
};

#endif
