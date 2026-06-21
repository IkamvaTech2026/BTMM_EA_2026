#ifndef __BTMM_PRICING_MQH__
#define __BTMM_PRICING_MQH__

//==================================================================
// UNIFIED PRICING CONVERSION LAYER
// Broker rules:
//   5 digits -> 1 pip = 10 points
//   4 digits -> 1 pip = 1 point
//   3 digits -> 1 pip = 10 points
//   2 digits -> 1 pip = 1 point
//==================================================================

class CPricingLayer
{
private:
   string m_symbol;
   int    m_digits;
   double m_point_size;
   double m_pip_size;

   void DetectSizes()
   {
      m_digits     = (int)SymbolInfoInteger(m_symbol, SYMBOL_DIGITS);
      m_point_size = SymbolInfoDouble(m_symbol, SYMBOL_POINT);

      switch(m_digits)
      {
         case 5:
         case 3:
            m_pip_size = m_point_size * 10.0;
            break;
         case 4:
         case 2:
            m_pip_size = m_point_size;
            break;
         default:
            m_pip_size = m_point_size * 10.0;
            break;
      }
   }

public:
   CPricingLayer() : m_symbol(""), m_digits(0), m_point_size(0), m_pip_size(0) {}
   CPricingLayer(string symbol) { Init(symbol); }

   void Init(string symbol)
   {
      m_symbol = symbol;
      DetectSizes();
   }

   string Symbol() const { return m_symbol; }
   double PipSize() const { return m_pip_size; }
   double PointSize() const { return m_point_size; }

   double PipsToPrice(double pips) const
   {
      if(pips == 0 || m_pip_size == 0) return 0;
      return pips * m_pip_size;
   }

   double PriceToPips(double price_distance) const
   {
      if(price_distance == 0 || m_pip_size == 0) return 0;
      return price_distance / m_pip_size;
   }

   int GetDigits() const { return m_digits; }
};

// Global pricing context
CPricingLayer g_pricing;

void PricingInit(string symbol)
{
   g_pricing.Init(symbol);
}

double PipSize() { return g_pricing.PipSize(); }
double PointSize() { return g_pricing.PointSize(); }
double PipsToPrice(double pips) { return g_pricing.PipsToPrice(pips); }
double PriceToPips(double price_distance) { return g_pricing.PriceToPips(price_distance); }

#endif
