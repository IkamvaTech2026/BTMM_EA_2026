#ifndef __BTMM_INDICATORS_MQH__
#define __BTMM_INDICATORS_MQH__

#include "BTMM_Defines.mqh"
#include "BTMM_Pricing.mqh"

class CIndicatorEngine
{
private:
   string m_symbol;
   ENUM_TIMEFRAMES m_period;
   int m_adr_period;
   double m_adr;
   double m_pivot;
   double m_r1;
   double m_r2;
   double m_s1;
   double m_s2;
   double m_prev_high;
   double m_prev_low;
   double m_prev_close;
   double m_today_open;
   int m_ema200_handle;
   int m_ema50_handle;
   int m_atr_handle;
   int m_atr_period;
   int m_h1_ema200_handle;

public:
   CIndicatorEngine(string symbol, ENUM_TIMEFRAMES period);
   ~CIndicatorEngine();

   bool Init();
   void Refresh();

   double GetADR() const { return m_adr; }
   double GetPivot() const { return m_pivot; }
   double GetR1() const { return m_r1; }
   double GetR2() const { return m_r2; }
   double GetS1() const { return m_s1; }
   double GetS2() const { return m_s2; }
   double GetPrevHigh() const { return m_prev_high; }
   double GetPrevLow() const { return m_prev_low; }
   double GetTodayOpen() const { return m_today_open; }
   double GetEMA(int period, int shift) const;
   double GetHTFEMA(ENUM_TIMEFRAMES tf, int period, int shift) const;
   double GetATR(int shift = 0) const;
   int GetATRHandle() const { return m_atr_handle; }
};

CIndicatorEngine::CIndicatorEngine(string symbol, ENUM_TIMEFRAMES period)
{
   m_symbol = symbol;
   m_period = period;
   m_adr_period = 14;
   m_adr = 0;
   m_pivot = 0;
   m_r1 = 0;
   m_r2 = 0;
   m_s1 = 0;
   m_s2 = 0;
   m_prev_high = 0;
   m_prev_low = 0;
   m_prev_close = 0;
   m_today_open = 0;
   m_ema200_handle = INVALID_HANDLE;
   m_ema50_handle = INVALID_HANDLE;
   m_atr_handle = INVALID_HANDLE;
   m_atr_period = 14;
   m_h1_ema200_handle = INVALID_HANDLE;
}

CIndicatorEngine::~CIndicatorEngine()
{
   if(m_ema200_handle != INVALID_HANDLE) IndicatorRelease(m_ema200_handle);
   if(m_ema50_handle != INVALID_HANDLE) IndicatorRelease(m_ema50_handle);
   if(m_atr_handle != INVALID_HANDLE) IndicatorRelease(m_atr_handle);
   if(m_h1_ema200_handle != INVALID_HANDLE) IndicatorRelease(m_h1_ema200_handle);
}

bool CIndicatorEngine::Init()
{
   m_ema200_handle = iMA(m_symbol, m_period, 200, 0, MODE_EMA, PRICE_CLOSE);
   m_ema50_handle = iMA(m_symbol, m_period, 50, 0, MODE_EMA, PRICE_CLOSE);
   m_atr_handle = iATR(m_symbol, m_period, m_atr_period);
   m_h1_ema200_handle = iMA(m_symbol, PERIOD_H1, 200, 0, MODE_EMA, PRICE_CLOSE);

   if(m_ema200_handle == INVALID_HANDLE || m_ema50_handle == INVALID_HANDLE ||
      m_atr_handle == INVALID_HANDLE || m_h1_ema200_handle == INVALID_HANDLE)
   {
      Print("BTMM Indicators: failed to create indicator handles");
      return false;
   }

   Refresh();
   return true;
}

void CIndicatorEngine::Refresh()
{
   double sum = 0;
   int valid_days = 0;

   for(int i = 1; i <= m_adr_period; i++)
   {
      double day_high = iHigh(m_symbol, PERIOD_D1, i);
      double day_low = iLow(m_symbol, PERIOD_D1, i);
      if(day_high <= 0 || day_low <= 0) continue;
      sum += day_high - day_low;
      valid_days++;
   }

   if(valid_days > 0)
      m_adr = sum / valid_days;

   m_prev_high = iHigh(m_symbol, PERIOD_D1, 1);
   m_prev_low = iLow(m_symbol, PERIOD_D1, 1);
   m_prev_close = iClose(m_symbol, PERIOD_D1, 1);
   m_today_open = iOpen(m_symbol, PERIOD_D1, 0);

   if(m_prev_high > 0 && m_prev_low > 0 && m_prev_close > 0)
   {
      m_pivot = (m_prev_high + m_prev_low + m_prev_close) / 3.0;
      m_r1 = 2.0 * m_pivot - m_prev_low;
      m_s1 = 2.0 * m_pivot - m_prev_high;
      m_r2 = m_pivot + (m_prev_high - m_prev_low);
      m_s2 = m_pivot - (m_prev_high - m_prev_low);
   }
}

double CIndicatorEngine::GetEMA(int period, int shift) const
{
   int handle = INVALID_HANDLE;
   if(period == 200)
      handle = m_ema200_handle;
   else if(period == 50)
      handle = m_ema50_handle;
   else
      return 0;

   if(handle == INVALID_HANDLE)
      return 0;

   double buffer[1];
   if(CopyBuffer(handle, 0, shift, 1, buffer) > 0)
      return buffer[0];

   return 0;
}

double CIndicatorEngine::GetHTFEMA(ENUM_TIMEFRAMES tf, int period, int shift) const
{
   if(tf == PERIOD_H1 && period == 200 && m_h1_ema200_handle != INVALID_HANDLE)
   {
      double buffer[1];
      if(CopyBuffer(m_h1_ema200_handle, 0, shift, 1, buffer) > 0)
         return buffer[0];
   }
   return 0;
}

double CIndicatorEngine::GetATR(int shift) const
{
   if(m_atr_handle == INVALID_HANDLE)
      return 0;

   double buffer[1];
   if(CopyBuffer(m_atr_handle, 0, shift, 1, buffer) > 0)
      return buffer[0];

   return 0;
}

#endif
