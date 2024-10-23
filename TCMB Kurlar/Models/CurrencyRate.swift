import Foundation

struct CurrencyRate: Identifiable {
    var id = UUID()
    var currencyCode: String // Döviz kodu, örn: USD, EUR
    var currencyName: [String: String] // İsimleri dil bazlı saklayacağız, örneğin ["tr": "Dolar", "en": "Dollar"]
    var crossOrder: Int // Sıralama

    // TCMB'den çekeceğimiz dinamik değerler
    var forexBuying: Double? = nil
    var forexSelling: Double? = nil
    var banknoteBuying: Double? = nil
    var banknoteSelling: Double? = nil
    var crossRateUSD: Double? = nil

    // Dil seçimine göre döviz adını almak için bir fonksiyon ekleyelim
    func getLocalizedCurrencyName() -> String {
        // Cihazın dilini almak için Locale kullanıyoruz
        let currentLocale = Locale.current.language.languageCode?.identifier ?? "en" // Eğer dil yoksa varsayılan "en"
        
        // Eğer seçili dilde isim varsa onu, yoksa varsayılan "en" dilini döndürelim
        return currencyName[currentLocale] ?? currencyName["en"] ?? "Unknown"
    }
}
