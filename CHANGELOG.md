# BTMM EA 2026 - Changelog

## [2.0.0] - 2026-06-21 - Institutional Grade Release

### ✨ Major Features Added

#### New Core Engines
- **Market Regime Engine**: Objective detection of TRENDING, RANGING, EXPANDING, COMPRESSING states
- **Liquidity Intelligence Engine**: Institutional-grade liquidity tracking with objective sweep scoring
- **Multi-Timeframe Context Engine**: D1/H4/H1/M15 alignment validation
- **Unified Trade Score Engine**: 0-100 objective scoring replacing binary entries
- **Data Collection Engine**: Complete CSV logging of all trades with metrics
- **Performance Analytics Engine**: Real-time win rate, profit factor, expectancy calculation
- **Institutional Risk Engine**: Daily/Weekly/Monthly limits with circuit breaker protection

#### Enhanced Components
- **BTMM_AdvancedTrading.mqh**: Complete rebuild with scale-in ladder, scratch trades, swing conversion
- **BTMM_RiskEngine.mqh**: Added volatility-adjusted position sizing
- **BTMM_Defines.mqh**: New structs for regime, scoring, portfolio state, trade logs
- **BTMM_Main.mq5**: Refactored to integrate all new engines

### 🔧 Technical Improvements

- **Zero Subjective Logic**: All "market maker intent" concepts replaced with measurable conditions
- **Memory Management**: Complete indicator handle cleanup and resource leak prevention
- **Backtesting Ready**: No future bar references, no repainting, tester-compatible
- **Configuration**: All weights, thresholds, and limits user-adjustable via inputs
- **Logging**: Complete trade data export for analysis and optimization
- **Documentation**: Comprehensive README with configuration guide and troubleshooting

### 📊 Scoring System

- **90-100**: Institutional Grade (high confidence)
- **80-89**: Grade A (strong signal)
- **70-79**: Grade B (acceptable)
- **60-69**: Grade C (marginal)
- **<60**: Rejected (insufficient confluence)

### ⚙️ Configuration Enhancements

```mql5
input int InpMinConfluence = 60;           // Minimum trade score threshold
input bool InpUseScaleIn = true;          // Enable 5:4:3:2:1 ladder
input int InpMaxScaleEntries = 3;         // Max scale positions
input double InpMinScaleDistancePips = 20; // Min distance between entries
input bool InpUseScratch = true;          // Auto-close on timeout
input double InpScratchTimeHours = 2.0;   // Scratch time threshold
input bool InpUseSwingConversion = true;  // Extend winning trades
```

### 🛡️ Risk Management

- Daily loss limit: 5.0% (configurable)
- Weekly loss limit: 10.0% (configurable)
- Monthly loss limit: 20.0% (configurable)
- Consecutive loss counter with pause trading
- Underwater equity protection
- Circuit breaker activation logging

### 📈 Performance Metrics

New real-time calculations:
- Win rate %
- Profit factor
- Expectancy per trade
- Average winning/losing trade
- Risk/Reward ratio
- Maximum drawdown
- Sharpe ratio (estimate)

### 🐛 Bug Fixes

- Fixed CAdvancedTradingEngine incomplete implementation
- Fixed CSessionNarrative not integrated in main
- Fixed CStopHuntEngine not instantiated
- Fixed indicator handle leaks in CIndicatorEngine
- Fixed CDiagnostics CSV logging broken
- Fixed OrderCalcMargin() broker compatibility issues
- Fixed time conversion for NFP filter

### 📝 Code Quality

- **0 compilation errors**
- **0 warnings**
- **No future bar references**
- **No memory leaks**
- **No indicator handle leaks**
- **Full error handling**
- **Complete documentation**

### 🔄 Migration Notes

Upgrading from v1.x:

1. All old input parameters remain compatible
2. New parameters are optional (defaults provided)
3. Old signal generators still work
4. New scoring is additive (non-breaking)
5. Trade logs exported to new CSV format

### 📦 File Structure

```
BTMM_EA_2026/
├── Include/ (19 files)
├── Experts/ (BTMM_Main.mq5)
├── Docs/ (optional guides)
├── README.md (complete documentation)
├── CHANGELOG.md (this file)
├── LICENSE (MIT)
└── .gitignore
```

---

## [1.2.0] - Previous Release

- Legacy BTMM functionality
- Subjective signal generation
- Basic risk management
- Limited logging

---

## Version Support

**Current Version**: 2.0.0 ✓ (Full Support)
**Previous Version**: 1.2.0 (Legacy Support)

---

**Last Updated**: June 21, 2026  
**Maintainer**: IkamvaTech2026  
**Status**: Production Ready
