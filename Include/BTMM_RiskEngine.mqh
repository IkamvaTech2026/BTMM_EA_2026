#ifndef __BTMM_RISKENGINE_MQH__
#define __BTMM_RISKENGINE_MQH__

#include "BTMM_Pricing.mqh"

class CRiskEngine
{
private:
   string m_symbol;
   
public:
   CRiskEngine();
   CRiskEngine(string symbol);
   ~CRiskEngine();
   
   double PipsToPrice(double pips);
   double PriceToPips(double price_distance);
   int GetPipDigits();
   
   double CalculatePositionSizeByRisk(
      double entry_price,
      double stop_loss_price,
      double risk_percent,
      double account_balance = 0
   );
   
   bool ValidateRisk(double lots, double entry, double sl, double tp);
   
   double GetTickSize();
   double GetTickValue();
   double GetContractSize();
   double GetMinLot();
   double GetMaxLot();
   double GetLotStep();
};

CRiskEngine::CRiskEngine()
{
   m_symbol = _Symbol;
}

CRiskEngine::CRiskEngine(string symbol)
{
   m_symbol = symbol;
}

CRiskEngine::~CRiskEngine()
{
}

int CRiskEngine::GetPipDigits()
{
   int digits = (int)SymbolInfoInteger(m_symbol, SYMBOL_DIGITS);
   if(digits == 5) return 4;
   if(digits == 4) return 3;
   if(digits == 3) return 2;
   if(digits == 2) return 1;
   return digits - 1;
}

double CRiskEngine::PipsToPrice(double pips)
{
   int pip_digits = GetPipDigits();
   double multiplier = MathPow(10, -pip_digits);
   return pips * multiplier;
}

double CRiskEngine::PriceToPips(double price_distance)
{
   int pip_digits = GetPipDigits();
   double divisor = MathPow(10, -pip_digits);
   return price_distance / divisor;
}

double CRiskEngine::GetTickSize()
{
   return SymbolInfoDouble(m_symbol, SYMBOL_TRADE_TICK_SIZE);
}

double CRiskEngine::GetTickValue()
{
   return SymbolInfoDouble(m_symbol, SYMBOL_TRADE_TICK_VALUE);
}

double CRiskEngine::GetContractSize()
{
   return SymbolInfoDouble(m_symbol, SYMBOL_TRADE_CONTRACT_SIZE);
}

double CRiskEngine::GetMinLot()
{
   return SymbolInfoDouble(m_symbol, SYMBOL_VOLUME_MIN);
}

double CRiskEngine::GetMaxLot()
{
   return SymbolInfoDouble(m_symbol, SYMBOL_VOLUME_MAX);
}

double CRiskEngine::GetLotStep()
{
   return SymbolInfoDouble(m_symbol, SYMBOL_VOLUME_STEP);
}

double CRiskEngine::CalculatePositionSizeByRisk(
   double entry_price,
   double stop_loss_price,
   double risk_percent,
   double account_balance
)
{
   if(account_balance <= 0)
      account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
   
   if(account_balance <= 0)
   {
      Print("ERROR: Invalid account balance");
      return 0;
   }
   
   double risk_amount = account_balance * (risk_percent / 100.0);
   
   if(risk_amount <= 0)
   {
      Print("ERROR: Invalid risk amount");
      return 0;
   }
   
   double tick_size = GetTickSize();
   double tick_value = GetTickValue();
   
   if(tick_size <= 0 || tick_value <= 0)
   {
      Print("ERROR: Invalid symbol parameters");
      return 0;
   }
   
   double price_distance = MathAbs(entry_price - stop_loss_price);
   
   if(price_distance <= 0)
   {
      Print("ERROR: Invalid stop loss price");
      return 0;
   }
   
   double num_ticks = price_distance / tick_size;
   
   if(num_ticks <= 0)
   {
      Print("ERROR: Invalid number of ticks");
      return 0;
   }
   
   double loss_per_lot = tick_value * num_ticks;
   
   if(loss_per_lot <= 0)
   {
      Print("ERROR: Invalid loss calculation");
      return 0;
   }
   
   double lots = risk_amount / loss_per_lot;
   
   double min_lot = GetMinLot();
   double max_lot = GetMaxLot();
   double lot_step = GetLotStep();
   
   if(lot_step > 0)
      lots = MathFloor(lots / lot_step) * lot_step;
   
   lots = MathMax(lots, min_lot);
   lots = MathMin(lots, max_lot);
   
   if(lots <= 0)
   {
      Print("WARNING: Calculated lots is 0, using minimum: ", min_lot);
      return min_lot;
   }
   
   return lots;
}

bool CRiskEngine::ValidateRisk(double lots, double entry, double sl, double tp)
{
   if(lots <= 0)
   {
      Print("ERROR: Invalid lot size: ", lots);
      return false;
   }
   
   double min_lot = GetMinLot();
   double max_lot = GetMaxLot();
   
   if(lots < min_lot || lots > max_lot)
   {
      Print("ERROR: Lot size ", lots, " outside range [", min_lot, "-", max_lot, "]");
      return false;
   }
   
   if(entry <= 0)
   {
      Print("ERROR: Invalid entry price");
      return false;
   }
   
   if(sl <= 0)
   {
      Print("ERROR: Invalid stop loss price");
      return false;
   }
   
   if(MathAbs(entry - sl) < GetTickSize())
   {
      Print("ERROR: Stop loss too close to entry");
      return false;
   }
   
   if(tp <= 0)
   {
      Print("ERROR: Invalid take profit price");
      return false;
   }
   
   bool long_trade = (entry > sl);
   bool tp_correct = long_trade ? (tp > entry) : (tp < entry);
   
   if(!tp_correct)
   {
      Print("ERROR: Take profit on wrong side of entry");
      return false;
   }
   
   double risk_points = MathAbs(entry - sl);
   double reward_points = MathAbs(tp - entry);
   double ratio = reward_points / risk_points;
   
   if(ratio < 1.0)
   {
      Print("WARNING: Risk/Reward ratio is ", ratio, " (less than 1:1)");
   }
   
   return true;
}

#endif
