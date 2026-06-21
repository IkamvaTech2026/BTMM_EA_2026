# BTMM EA 2026 - Institutional Grade Trading System

## Overview

BTMM (Break The Money Machine) Expert Advisor 2026 is a professional-grade, quantitative trading system for MetaTrader 5. This version represents a complete institutional upgrade from the original BTMM methodology, converting all subjective trading concepts into measurable, objective, backtestable components.

## Key Features

✅ **Objective Market Regime Detection** - TRENDING, RANGING, EXPANDING, COMPRESSING
✅ **Institutional Risk Management** - Daily/Weekly/Monthly limits with circuit breaker
✅ **Liquidity Intelligence Engine** - Objective sweep detection and scoring
✅ **Multi-Timeframe Context** - D1/H4/H1/M15 alignment validation
✅ **Unified Trade Scoring** - 0-100 objective score with component breakdown
✅ **Advanced Trade Management** - Scale-in ladder (5:4:3:2:1), scratch trades, swing conversion
✅ **Complete Data Logging** - CSV export with all trade metrics
✅ **Performance Analytics** - Real-time win rate, profit factor, expectancy
✅ **Zero Memory Leaks** - Full handle management and cleanup
✅ **Production Ready** - 100% backtestable, zero warnings, fully documented

## Installation

### Step 1: Clone Repository
```bash
git clone https://github.com/IkamvaTech2026/BTMM_EA_2026.git
```

### Step 2: Copy Files to MQL5

**Include Files** (`Include/` folder → MQL5\Include\):
- Copy all `.mqh` files from the `Include/` directory

**Expert Advisor** (`Experts/` folder → MQL5\Experts\):
- Copy `BTMM_Main.mq5` to your Experts folder

**Default Paths:**
```
Include:  C:\Users\[YourUsername]\AppData\Roaming\MetaQuotes\Terminal\[TerminalID]\MQL5\Include\
Experts:  C:\Users\[YourUsername]\AppData\Roaming\MetaQuotes\Terminal\[TerminalID]\MQL5\Experts\
```

### Step 3: Compile

1. Open MetaTrader 5
2. Tools → MetaQuotes Language Editor (F5)
3. File → Open → BTMM_Main.mq5
4. Press Compile (Ctrl+Shift+F9)
5. Verify: **0 errors, 0 warnings** ✓

### Step 4: Deploy

1. Drag `BTMM_Main.mq5` onto an M15 chart
2. Configure parameters in the dialog
3. Enable "Algo Trading" if prompted
4. Click OK

## File Structure

```
BTMM_EA_2026/
├── Include/
│   ├── BTMM_Defines.mqh              # Core data structures & enums
│   ├── BTMM_Pricing.mqh              # Pip/point conversion layer
│   ├── BTMM_RiskEngine.mqh           # Risk calculation & validation
│   ├── BTMM_Sessions.mqh             # Session time windows & Asian range
│   ├── BTMM_Indicators.mqh           # Indicator engine (EMA, ATR, pivots)
│   ├── BTMM_MarketCycle.mqh          # M/W patterns, HOD/LOD tracking
│   ├── BTMM_SignalEngine.mqh         # 7 signal generators
│   ├── BTMM_TradeManager.mqh         # Trade execution & management
│   ├── BTMM_AdvancedTrading.mqh      # Scale-in, scratch, swing conversion
│   ├── BTMM_SessionNarrative.mqh     # Session bias tracking
│   ├── BTMM_SafetyDiagnostics.mqh    # Execution safety & diagnostics
│   ├── BTMM_PortfolioRisk.mqh        # Portfolio-level risk limits
│   ├── BTMM_StopHuntPattern.mqh      # Stop hunt & pattern analysis
│   ├── BTMM_MarketMaker.mqh          # Market maker phase detection
│   ├── BTMM_Dashboard.mqh            # On-chart visualization
│   ├── PRIORITY_1_PipPointAudit.mqh  # Legacy alias
│   ├── PRIORITY_2_MarketMakerEnhanced.mqh
│   ├── PRIORITY_3_LiquidityEngine.mqh
│   └── PRIORITY_4_ExecutionValidator.mqh
├── Experts/
│   └── BTMM_Main.mq5                 # Main EA orchestrator
├── README.md                          # This file
├── CHANGELOG.md                       # Version history
├── LICENSE                           # MIT License
└── .gitignore                        # Git ignore rules
```

## Configuration Parameters

### General Settings
```
Magic Number:          20260621 (unique EA identifier)
GMT Offset:            2 (adjust to your broker)
Auto-Detect GMT:       false (manual offset preferred)
```

### Trading Settings
```
Enable Trading:        true
Risk Per Trade:        1.0% of balance
Use Fixed Lots:        true
Fixed Lot Size:        0.1
Minimum Confluence:    60 (0-100 score)
```

### Setup Filters
```
Trade M/W Leg 2:       true (bread & butter setup)
Trade 33 Setup:        true (1/3 - 2/3 retracement)
Trade NYC Reversal:    true (US open fade)
Trade EMA200 Bounce:   true (EMA pullback reversal)
Trade Swing:           false (manual preferred)
Trade Straightaway:    false (optional)
Trade Half Batman:     false (optional)
Trade Stop Hunt:       false (optional)
```

### Risk Limits
```
Max Open Risk:         3.0% of balance
Max Daily Loss:        5.0% (circuit breaker)
Max Weekly Loss:       10.0% (circuit breaker)
Max Open Trades:       3 (simultaneous)
Max Spread:            3.0 pips
```

### Advanced Trading
```
Use Scale-In:          true (5:4:3:2:1 ladder)
Max Scale Entries:     3
Min Scale Distance:    20 pips
Use Scratch Trades:    true (auto-close on timeout)
Scratch Time:          2.0 hours
Use Swing Conversion:  true (extend profitable trades)
```

## Core Engines

### 1. Market Regime Engine
Detects objective market conditions:
- **TRENDING_UP**: ADX > 25, close > EMA200
- **TRENDING_DOWN**: ADX > 25, close < EMA200
- **RANGING**: ADX < 20, tight EMA convergence
- **EXPANDING**: ATR > 75th percentile
- **COMPRESSING**: ATR < 25th percentile

### 2. Liquidity Intelligence Engine
Tracks institutional liquidity levels:
- Previous Day High/Low (PDH/PDL)
- Weekly/Monthly extremes
- Asian session ranges
- Objective sweep detection with confidence scoring

### 3. Multi-Timeframe Context Engine
Validates alignment across timeframes:
- D1 trend confirmation
- H4 directional bias (ADX-based)
- H1 EMA200 alignment
- M15 entry signal formation

### 4. Unified Trade Score Engine
Objective 0-100 scoring:
- **Liquidity Sweep** (0-20 points)
- **HTF Alignment** (0-20 points)
- **Session Alignment** (0-15 points)
- **ADR Context** (0-15 points)
- **Regime Alignment** (0-10 points)
- **Volatility Alignment** (0-10 points)
- **Structure Confirmation** (0-10 points)

**Trade Categories:**
- **90-100**: Institutional Grade (execute with confidence)
- **80-89**: Grade A (strong signal)
- **70-79**: Grade B (acceptable)
- **60-69**: Grade C (marginal)
- **<60**: Rejected (insufficient confluence)

### 5. Advanced Trade Management
- **Scale-In**: Add positions on confirmation (5:4:3:2:1 lots)
- **Scratch Trades**: Auto-close if no movement after 2 hours
- **Swing Conversion**: Extend winning trades to longer timeframe

### 6. Institutional Risk Engine
- Daily loss limits with circuit breaker
- Weekly drawdown protection
- Monthly account protection
- Consecutive loss counter
- Automatic trading suspension

### 7. Data Collection & Analytics
- Complete trade logging to CSV
- Performance metrics calculation
- Win rate, profit factor, expectancy tracking
- Walk-forward performance analysis ready

## Performance Expectations

**Historical BTMM Methodology:**
- Win Rate: 55-65%
- Profit Factor: 1.5-2.5
- Risk/Reward: 1:1.5 to 1:2.5
- Max Drawdown: 8-12% (with circuit breaker)

**This Version Improvements:**
- Objective scoring eliminates discretionary entries
- Strict risk limits prevent catastrophic losses
- Complete logging enables optimization
- Multi-timeframe alignment improves accuracy

## Backtesting

### Strategy Tester Settings
```
Symbol:              EURUSD (primary)
Period:              M15 (as designed)
Data:                Every tick (most accurate)
Spread:              Default (variable)
Commission:          Your broker's actual commission
Slippage:            2-5 pips (realistic)
```

### Recommended Test Parameters
- **Initial Deposit**: $10,000 USD
- **Test Period**: 3-6 months minimum
- **Optimization**: Walk-forward with 4-week windows
- **Out-of-Sample**: Final 1-2 weeks

## Troubleshooting

### Compilation Errors

| Error | Solution |
|-------|----------|
| "#include file not found" | Verify all `.mqh` files in Include folder |
| "Undefined symbol" | Check dependencies in correct order |
| "Syntax error" | Re-download file (copy corruption) |
| "Cannot create EA" | BTMM_Main.mq5 must be in Experts folder |

### Runtime Issues

| Issue | Solution |
|-------|----------|
| No signals | Check instrument, verify Algo Trading enabled |
| Signals but no trades | Check risk limits not breached, spread acceptable |
| Memory leak warnings | Ensure all versions are up-to-date |
| Slippage on fills | Adjust MaxSpread parameter lower |

## Performance Monitoring

### Dashboard Display
- Current market regime + confidence
- Liquidity score for price level
- HTF alignment status
- Session context
- Open trade P&L
- Circuit breaker status

### CSV Log Output
```
BTMM_[Symbol]_[Period]_[Date].csv
```

Columns:
- Timestamp
- Symbol, Direction, Setup Type
- Entry, Exit, Stop Loss
- Trade Score, Market Regime
- Session, PnL, Risk/Reward
- MFE (Max Favorable Excursion)
- MAE (Max Adverse Excursion)
- Close Reason

## Risk Disclosure

⚠️ **IMPORTANT**: Trading forex and derivatives involves substantial risk. Past performance does not guarantee future results. Always:

1. Test thoroughly on historical data first
2. Paper trade before live deployment
3. Start with minimal position sizing
4. Maintain strict risk discipline
5. Monitor equity curve daily
6. Use circuit breaker features

## Support & Updates

- **Issues**: Report at https://github.com/IkamvaTech2026/BTMM_EA_2026/issues
- **Updates**: Check CHANGELOG.md for new versions
- **Documentation**: See Docs/ folder for detailed guides

## License

MIT License - See LICENSE file for details

## Changelog

See CHANGELOG.md for complete version history

---

**Version**: 2.0.0 (Institutional Grade)  
**Last Updated**: June 21, 2026  
**Status**: Production Ready ✓
