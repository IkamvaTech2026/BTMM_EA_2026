#ifndef __BTMM_SESSIONS_MQH__
#define __BTMM_SESSIONS_MQH__

#include "BTMM_Defines.mqh"
#include "BTMM_Pricing.mqh"

class CSessionManager
{
private:
   string m_symbol;
   ENUM_TIMEFRAMES m_period;
   int m_gmt_offset;
   SAsianRange m_asian_range;
   int m_last_reset_day;

   int GetDayKey(datetime t) const;

public:
   CSessionManager(string symbol, ENUM_TIMEFRAMES period, int gmt_offset);
   ~CSessionManager();

   int GetETHour(datetime t) const;
   int GetETMinute(datetime t) const;

   void ResetDaily(datetime t);
   bool IsDailyResetTime(datetime t);
   void UpdateAsianRange(datetime t, double high, double low);
   SAsianRange GetAsianRange();

   bool IsAsiaRangeWindow(datetime t) const;
   bool IsLondonTradingWindow(datetime t);
   bool IsUSOpenWindow(datetime t);
   bool IsAsiaGap(datetime t);
   bool IsEuropeGap(datetime t);
};

CSessionManager::CSessionManager(string symbol, ENUM_TIMEFRAMES period, int gmt_offset)
{
   m_symbol = symbol;
   m_period = period;
   m_gmt_offset = gmt_offset;
   m_last_reset_day = -1;
   ZeroMemory(m_asian_range);
}

CSessionManager::~CSessionManager()
{
}

int CSessionManager::GetDayKey(datetime t) const
{
   MqlDateTime dt;
   TimeToStruct(t, dt);
   return dt.year * 10000 + dt.mon * 100 + dt.day;
}

int CSessionManager::GetETHour(datetime t) const
{
   MqlDateTime dt;
   TimeToStruct(t, dt);
   int et_hour = dt.hour - m_gmt_offset + 5;
   if(et_hour < 0) et_hour += 24;
   if(et_hour > 23) et_hour -= 24;
   return et_hour;
}

int CSessionManager::GetETMinute(datetime t) const
{
   MqlDateTime dt;
   TimeToStruct(t, dt);
   return dt.min;
}

void CSessionManager::ResetDaily(datetime t)
{
   int day_key = GetDayKey(t);
   if(day_key != m_last_reset_day)
   {
      m_last_reset_day = day_key;
      ZeroMemory(m_asian_range);
   }

   if(IsDailyResetTime(t))
      ZeroMemory(m_asian_range);
}

bool CSessionManager::IsDailyResetTime(datetime t)
{
   MqlDateTime dt;
   TimeToStruct(t, dt);
   return (GetETHour(t) == 0 && dt.min == 0);
}

bool CSessionManager::IsAsiaRangeWindow(datetime t) const
{
   int et_hour = GetETHour(t);
   return (et_hour >= 0 && et_hour < 5);
}

void CSessionManager::UpdateAsianRange(datetime t, double high, double low)
{
   if(!IsAsiaRangeWindow(t))
      return;

   if(!m_asian_range.valid)
   {
      m_asian_range.high = high;
      m_asian_range.low = low;
      m_asian_range.valid = true;
   }
   else
   {
      if(high > m_asian_range.high) m_asian_range.high = high;
      if(low < m_asian_range.low) m_asian_range.low = low;
   }

   m_asian_range.range_pips = (int)PriceToPips(m_asian_range.high - m_asian_range.low);
}

SAsianRange CSessionManager::GetAsianRange()
{
   return m_asian_range;
}

bool CSessionManager::IsLondonTradingWindow(datetime t)
{
   int et_hour = GetETHour(t);
   return (et_hour >= 1 && et_hour < 5);
}

bool CSessionManager::IsUSOpenWindow(datetime t)
{
   int et_hour = GetETHour(t);
   return (et_hour >= 8 && et_hour < 11);
}

bool CSessionManager::IsAsiaGap(datetime t)
{
   int et_hour = GetETHour(t);
   int et_min = GetETMinute(t);
   return (et_hour == 19 && et_min >= 0 && et_min < 30);
}

bool CSessionManager::IsEuropeGap(datetime t)
{
   int et_hour = GetETHour(t);
   int et_min = GetETMinute(t);
   return (et_hour == 2 && et_min >= 0 && et_min < 30);
}

#endif
