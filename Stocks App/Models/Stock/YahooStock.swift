//
//  Stock.swift
//  Stocks App
//
//  Created by liram vahadi on 12/02/2021.
//

import Foundation

// MARK: - YahooStock
struct YahooStock: Codable {
    let netSharePurchaseActivity: NetSharePurchaseActivity?
    let financialData: FinancialData?
    let mktmData: Details?
    let majorHoldersBreakdown: MajorHoldersBreakdown?
    let institutionOwnership: Ownership?
    let summaryProfile: SummaryProfile?
    let defaultKeyStatistics: DefaultKeyStatistics?
    let quoteType: QuoteType?
    let fundOwnership: Ownership?
    let details: Details?
    let symbol: String?
    let pageViews: PageViews?
    let earnings: YahooStockEarnings?
    let esgScores: EsgScores?
    let calendarEvents: CalendarEvents?
    let price: Price?
    let recommendationTrend: RecommendationTrend?
    let financialsTemplate: FinancialsTemplate?
}


// MARK: - CalendarEvents
struct CalendarEvents: Codable {
    let maxAge: Int
    let earnings: CalendarEventsEarnings
    let exDividendDate, dividendDate: DividendDate
}


// MARK: - DividendDate
struct DividendDate: Codable {
    let raw: Double?
    let fmt: String?
}


// MARK: - CalendarEventsEarnings
struct CalendarEventsEarnings: Codable {
    let revenueHigh: EnterpriseValue?
    let earningsAverage: DividendDate?
    let earningsDate: [DividendDate]?
    let earningsHigh: DividendDate?
    let revenueAverage, revenueLow: EnterpriseValue?
    let earningsLow: DividendDate?
}

// MARK: - EnterpriseValue
struct EnterpriseValue: Codable {
    let raw: Int?
    let fmt: String?
    let longFmt: String?
}

// MARK: - DefaultKeyStatistics
struct DefaultKeyStatistics: Codable {
    let earningsQuarterlyGrowth: Details?
    let forwardPE: DividendDate?
    let lastCapGain: Details?
    let sharesPercentSharesOut: DividendDate?
    let yield: Details?
    let sandP52WeekChange, lastDividendDate: DividendDate?
    let enterpriseToEbitda, pegRatio: DividendDate?
    let sharesOutstanding: EnterpriseValue?
    let forwardEps, priceToBook, shortRatio, beta: DividendDate?
    let priceHint: EnterpriseValue?
    let lastFiscalYearEnd: DividendDate?
    let annualReportExpenseRatio, revenueQuarterlyGrowth, annualHoldingsTurnover, fundInceptionDate: Details?
    let lastSplitDate: Details?
    let morningStarRiskRating: Details?
    let floatShares, sharesShort: EnterpriseValue?
    let nextFiscalYearEnd: DividendDate?
    let ytdReturn: Details?
    let bookValue: DividendDate?
    let beta3Year: Details?
    let shortPercentOfFloat, dateShortInterest, enterpriseToRevenue: DividendDate?
    let enterpriseValue: EnterpriseValue?
    let fiveYearAverageReturn: Details?
    let lastDividendValue: DividendDate?
    let maxAge: Int?
    let sharesShortPreviousMonthDate, trailingEps: DividendDate?
    let priceToSalesTrailing12Months: Details?
    let profitMargins: DividendDate?
    let impliedSharesOutstanding: Details?
    let mostRecentQuarter: DividendDate?
    let threeYearAverageReturn: Details?
    let heldPercentInsiders, heldPercentInstitutions: DividendDate?
    let morningStarOverallRating, totalAssets: Details?
    let the52WeekChange: DividendDate?
    let sharesShortPriorMonth, netIncomeToCommon: EnterpriseValue?

    enum CodingKeys: String, CodingKey {
        case earningsQuarterlyGrowth, forwardPE, lastCapGain, sharesPercentSharesOut, yield
        case sandP52WeekChange = "SandP52WeekChange"
        case lastDividendDate, enterpriseToEbitda, pegRatio, sharesOutstanding, forwardEps, priceToBook, shortRatio, beta, priceHint, lastFiscalYearEnd, annualReportExpenseRatio, revenueQuarterlyGrowth, annualHoldingsTurnover, fundInceptionDate,lastSplitDate ,morningStarRiskRating, floatShares, sharesShort, nextFiscalYearEnd, ytdReturn, bookValue, beta3Year, shortPercentOfFloat, dateShortInterest, enterpriseToRevenue, enterpriseValue, fiveYearAverageReturn, lastDividendValue, maxAge, sharesShortPreviousMonthDate, trailingEps, priceToSalesTrailing12Months, profitMargins, impliedSharesOutstanding, mostRecentQuarter, threeYearAverageReturn, heldPercentInsiders, heldPercentInstitutions, morningStarOverallRating, totalAssets
        case the52WeekChange = "52WeekChange"
        case sharesShortPriorMonth, netIncomeToCommon
    }
}

// MARK: - Details
struct Details: Codable {
}


// MARK: - YahooStockEarnings
struct YahooStockEarnings: Codable {
    let maxAge: Int?
    let financialsChart: FinancialsChart?
    let earningsChart: EarningsChart?
    let financialCurrency: String?
}

// MARK: - EarningsChart
struct EarningsChart: Codable {
    let currentQuarterEstimateYear: Int?
    let quarterly: [EarningsChartQuarterly]?
    let earningsDate: [DividendDate]?
    let currentQuarterEstimate: DividendDate?
    let currentQuarterEstimateDate: String?
}

// MARK: - EarningsChartQuarterly
struct EarningsChartQuarterly: Codable {
    let date: String?
    let actual, estimate: DividendDate?
}

// MARK: - FinancialsChart
struct FinancialsChart: Codable {
    let quarterly: [FinancialsChartQuarterly]?
    let yearly: [Yearly]?
}

// MARK: - FinancialsChartQuarterly
struct FinancialsChartQuarterly: Codable {
    let date: String?
    let revenue, earnings: EnterpriseValue?
}

// MARK: - Yearly
struct Yearly: Codable {
    let date: Int?
    let revenue, earnings: EnterpriseValue?
}

// MARK: - EsgScores
struct EsgScores: Codable {
    let gmo: Bool?
    let percentile: DividendDate?
    let highestControversy: Int?
    let palmOil: Bool?
    let peerSocialPerformance: PeerPerformance?
    let alcoholic, pesticides: Bool?
    let governanceScore, environmentScore: DividendDate?
    let peerGovernancePerformance: PeerPerformance?
    let peerCount: Int?
    let smallArms: Bool?
    let relatedControversy: [String]?
    let animalTesting: Bool?
    let maxAge: Int?
    let controversialWeapons, militaryContract: Bool?
    let peerEsgScorePerformance: PeerPerformance?
    let furLeather, coal: Bool?
    let peerGroup: String?
    let socialScore: DividendDate?
    let totalEsg: DividendDate?
    let peerEnvironmentPerformance: PeerPerformance?
    let nuclear, gambling: Bool?
    let ratingMonth: Int?
    let catholic, tobacco, adult: Bool?
    let ratingYear: Int?
    let esgPerformance: String?
    let peerHighestControversyPerformance: PeerPerformance?
}

// MARK: - PeerPerformance
struct PeerPerformance: Codable {
    let min, avg, max: Double
}

// MARK: - FinancialData
struct FinancialData: Codable {
    let returnOnAssets: DividendDate?
    let numberOfAnalystOpinions: EnterpriseValue?
    let targetMedianPrice: DividendDate?
    let totalRevenue: EnterpriseValue?
    let grossMargins, targetLowPrice: DividendDate?
    let maxAge: Int?
    let currentRatio: DividendDate?
    let operatingCashflow: EnterpriseValue?
    let financialCurrency: String?
    let ebitda: EnterpriseValue?
    let returnOnEquity, targetMeanPrice, revenueGrowth: DividendDate?
    let grossProfits: EnterpriseValue?
    let revenuePerShare: DividendDate?
    let freeCashflow: EnterpriseValue?
    let quickRatio: DividendDate?
    let totalCash, totalDebt: EnterpriseValue?
    let profitMargins: DividendDate?
    let recommendationKey: String?
    let currentPrice, debtToEquity, operatingMargins, targetHighPrice: DividendDate?
    let totalCashPerShare, ebitdaMargins, recommendationMean: DividendDate?
    let earningsGrowth: Details?
}

// MARK: - FinancialsTemplate
struct FinancialsTemplate: Codable {
    let maxAge: Int?
    let code: String?
}

// MARK: - Ownership
struct Ownership: Codable {
    let maxAge: Int?
    let ownershipList: [OwnershipList]?
}

// MARK: - OwnershipList
struct OwnershipList: Codable {
    let maxAge: Int?
    let organization: String?
    let pctHeld: DividendDate?
    let value: EnterpriseValue?
    let reportDate: DividendDate?
    let position: EnterpriseValue?
}

enum OwnershipEnum: String, Codable {
    case d = "D"
    case i = "I"
}

// MARK: - MajorHoldersBreakdown
struct MajorHoldersBreakdown: Codable {
    let maxAge: Int?
    let institutionsCount: EnterpriseValue?
    let institutionsPercentHeld, insidersPercentHeld, institutionsFloatPercentHeld: DividendDate?
}

// MARK: - NetSharePurchaseActivity
struct NetSharePurchaseActivity: Codable {
    let netInfoCount: EnterpriseValue?
    let period: String?
    let buyPercentInsiderShares: DividendDate?
    let buyInfoShares, sellInfoShares: EnterpriseValue?
    let maxAge: Int?
    let netInfoShares, totalInsiderShares: EnterpriseValue?
    let netPercentInsiderShares: DividendDate?
    let sellInfoCount: EnterpriseValue?
    let sellPercentInsiderShares: DividendDate?
    let buyInfoCount: EnterpriseValue?
}

// MARK: - PageViews
struct PageViews: Codable {
    let longTermTrend: String?
    let maxAge: Int?
    let midTermTrend, shortTermTrend: String?
}

// MARK: - Price
struct Price: Codable {
    let symbol, currency: String?
    let volume24Hr: Details?
    let preMarketSource: String?
    let regularMarketPreviousClose, postMarketChange: DividendDate?
    let regularMarketPrice: DividendDate
    let postMarketTime: Int?
    let averageDailyVolume3Month: EnterpriseValue?
    let circulatingSupply, openInterest: Details?
    let exchangeDataDelayedBy: Int?
    let currencySymbol: String?
    let maxAge, regularMarketTime: Int?
    let postMarketSource: String?
    let strikePrice: Details?
    let regularMarketDayLow: DividendDate?
    let regularMarketVolume: EnterpriseValue?
    let postMarketChangePercent, postMarketPrice: DividendDate?
    let averageDailyVolume10Day: EnterpriseValue?
    let regularMarketOpen: DividendDate?
    let exchange, marketState, longName: String?
    let preMarketChange: Details?
    let regularMarketChangePercent: DividendDate?
    let quoteSourceName: String?
    let regularMarketChange: DividendDate?
    let exchangeName: String?
    let preMarketPrice: Details?
    let shortName, regularMarketSource: String?
    let priceHint: EnterpriseValue?
    let quoteType: String?
    let marketCap: EnterpriseValue?
    let volumeAllCurrencies: Details?
    let regularMarketDayHigh: DividendDate?
}

// MARK: - Company
struct Company: Codable {
    let region, symbol, currency: String?
    let fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, regularMarketPreviousClose: DividendDate?
    let invalid: Bool?
    let fiftyTwoWeekHighChange, regularMarketPrice: DividendDate?
    let sharesOutstanding: EnterpriseValue?
    let exchangeTimezoneShortName: String?
    let exchangeDataDelayedBy: Int?
    let uuid: String?
    let fiftyTwoWeekHighChangePercent: DividendDate?
    let firstTradeDateMilliseconds: Int?
    let regularMarketTime: DividendDate?
    let isLoading: Bool?
    let regularMarketDayLow: DividendDate?
    let exchangeTimezoneName: String?
    let regularMarketVolume: EnterpriseValue?
    let fiftyTwoWeekLow: DividendDate?
    let regularMarketDayRange: Range?
    let fullExchangeName: String?
    let regularMarketOpen: DividendDate?
    let exchange, marketState: String?
    let sourceInterval: Int?
    let longName: String?
    let gmtOffSetMilliseconds: Int?
    let triggerable, tradeable: Bool?
    let regularMarketChangePercent: DividendDate?
    let quoteSourceName: String?
    let regularMarketChange: DividendDate?
    let fiftyTwoWeekRange: Range?
    let shortName: String?
    let priceHint: Int?
    let messageBoardID, language, quoteType: String?
    let marketCap: EnterpriseValue?
    let fiftyTwoWeekHigh: DividendDate?
    let market: String?
    let regularMarketDayHigh: DividendDate?

    enum CodingKeys: String, CodingKey {
        case region, symbol, currency, fiftyTwoWeekLowChange, fiftyTwoWeekLowChangePercent, regularMarketPreviousClose, invalid, fiftyTwoWeekHighChange, regularMarketPrice, sharesOutstanding, exchangeTimezoneShortName, exchangeDataDelayedBy, uuid, fiftyTwoWeekHighChangePercent, firstTradeDateMilliseconds, regularMarketTime, isLoading, regularMarketDayLow, exchangeTimezoneName, regularMarketVolume, fiftyTwoWeekLow, regularMarketDayRange, fullExchangeName, regularMarketOpen, exchange, marketState, sourceInterval, longName, gmtOffSetMilliseconds, triggerable, tradeable, regularMarketChangePercent, quoteSourceName, regularMarketChange, fiftyTwoWeekRange, shortName, priceHint
        case messageBoardID = "messageBoardId"
        case language, quoteType, marketCap, fiftyTwoWeekHigh, market, regularMarketDayHigh
    }
}

// MARK: - Range
struct Range: Codable {
    let raw, fmt: String?
}

// MARK: - QuoteType
struct QuoteType: Codable {
    let symbol, quoteType, shortName, longName: String?
    let exchange, exchangeTimezoneShortName, messageBoardID, market: String?
    let exchangeTimezoneName: String?
    let isEsgPopulated: Bool?
    let gmtOffSetMilliseconds: String?

    enum CodingKeys: String, CodingKey {
        case symbol, quoteType, shortName, longName, exchange, exchangeTimezoneShortName
        case messageBoardID = "messageBoardId"
        case market, exchangeTimezoneName, isEsgPopulated, gmtOffSetMilliseconds
    }
}

// MARK: - RecommendationTrend
struct RecommendationTrend: Codable {
    let trend: [Trend]?
    let maxAge: Int?
}

// MARK: - Trend
struct Trend: Codable {
    let strongSell, sell, strongBuy: Int?
    let period: String?
    let hold, buy: Int?
}

// MARK: - SummaryProfile
struct SummaryProfile: Codable {
    let state, zip, phone: String?
    let industry: String?
    let address1, longBusinessSummary: String?
    let maxAge: Int?
    let city: String?
    let fullTimeEmployees: Int?
    let sector, country: String?
    let website: String?
}

