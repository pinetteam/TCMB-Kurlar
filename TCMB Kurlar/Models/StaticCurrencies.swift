import Foundation

// Static currencies list, which includes fixed data (codes, names, order)
var staticCurrencies: [CurrencyRate] = [
    CurrencyRate(currencyCode: "TRY", currencyName: ["tr": "Türk Lirası", "en": "Turkish Lira"], crossOrder: 1),
    CurrencyRate(currencyCode: "USD", currencyName: ["tr": "ABD Doları", "en": "US Dollar"], crossOrder: 2),
    CurrencyRate(currencyCode: "AUD", currencyName: ["tr": "Avustralya Doları", "en": "Australian Dollar"], crossOrder: 3),
    CurrencyRate(currencyCode: "DKK", currencyName: ["tr": "Danimarka Kronu", "en": "Danish Krone"], crossOrder: 4),
    CurrencyRate(currencyCode: "EUR", currencyName: ["tr": "Euro", "en": "Euro"], crossOrder: 5),
    CurrencyRate(currencyCode: "GBP", currencyName: ["tr": "İngiliz Sterlini", "en": "Pound Sterling"], crossOrder: 6),
    CurrencyRate(currencyCode: "CHF", currencyName: ["tr": "İsviçre Frangı", "en": "Swiss Frank"], crossOrder: 7),
    CurrencyRate(currencyCode: "SEK", currencyName: ["tr": "İsveç Kronu", "en": "Swedish Krona"], crossOrder: 8),
    CurrencyRate(currencyCode: "CAD", currencyName: ["tr": "Kanada Doları", "en": "Canadian Dollar"], crossOrder: 9),
    CurrencyRate(currencyCode: "KWD", currencyName: ["tr": "Kuveyt Dinarı", "en": "Kuwaiti Dinar"], crossOrder: 10),
    CurrencyRate(currencyCode: "NOK", currencyName: ["tr": "Norveç Kronu", "en": "Norwegian Krone"], crossOrder: 11),
    CurrencyRate(currencyCode: "SAR", currencyName: ["tr": "Suudi Arabistan Riyali", "en": "Saudi Riyal"], crossOrder: 12),
    CurrencyRate(currencyCode: "JPY", currencyName: ["tr": "Japon Yeni", "en": "Japanese Yen"], crossOrder: 13),
    CurrencyRate(currencyCode: "BGN", currencyName: ["tr": "Bulgar Levası", "en": "Bulgarian Lev"], crossOrder: 14),
    CurrencyRate(currencyCode: "RON", currencyName: ["tr": "Rumen Leyi", "en": "New Leu"], crossOrder: 15),
    CurrencyRate(currencyCode: "RUB", currencyName: ["tr": "Rus Rublesi", "en": "Russian Rouble"], crossOrder: 16),
    CurrencyRate(currencyCode: "IRR", currencyName: ["tr": "İran Riyali", "en": "Iranian Rial"], crossOrder: 17),
    CurrencyRate(currencyCode: "CNY", currencyName: ["tr": "Çin Yuanı", "en": "Chinese Renminbi"], crossOrder: 18),
    CurrencyRate(currencyCode: "PKR", currencyName: ["tr": "Pakistan Rupisi", "en": "Pakistani Rupee"], crossOrder: 19),
    CurrencyRate(currencyCode: "QAR", currencyName: ["tr": "Katar Riyali", "en": "Qatari Rial"], crossOrder: 20),
    CurrencyRate(currencyCode: "KRW", currencyName: ["tr": "Güney Kore Wonu", "en": "South Korean Won"], crossOrder: 21),
    CurrencyRate(currencyCode: "AZN", currencyName: ["tr": "Azerbaycan Yeni Manatı", "en": "Azerbaijani New Manat"], crossOrder: 22),
    CurrencyRate(currencyCode: "AED", currencyName: ["tr": "Birleşik Arap Emirlikleri Dirhemi", "en": "United Arab Emirates Dirham"], crossOrder: 23)
]
