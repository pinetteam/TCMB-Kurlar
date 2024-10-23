import Foundation

class TCMBService: NSObject, XMLParserDelegate {
    private var currentElement = ""
    private var currentCurrencyCode = ""
    
    private var forexBuying = ""
    private var forexSelling = ""
    private var banknoteBuying = ""
    private var banknoteSelling = ""
    private var crossRateUSD = ""
    
    private var completion: (([CurrencyRate]) -> Void)?

    // Function to fetch exchange rates from the API
    func fetchExchangeRates(completion: @escaping ([CurrencyRate]) -> Void) {
        self.completion = completion
        guard let url = URL(string: "https://www.tcmb.gov.tr/kurlar/today.xml") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Data fetching error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received from API")
                return
            }

            // XML verisini olduğu gibi yazdır (kontrol amaçlı)
            if let xmlString = String(data: data, encoding: .utf8) {
                print("XML Response: \(xmlString)")
            }

            // XML parsing işlemi
            let parser = XMLParser(data: data)
            parser.delegate = self

            if parser.parse() {
                DispatchQueue.main.async {
                    // Use the staticCurrencies list and update it with dynamic exchange rates
                    self.completion?(staticCurrencies)
                }
            } else {
                print("XML parsing error")
            }
        }
        task.resume()
    }

    // Start parsing XML elements
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "Currency" {
            currentCurrencyCode = attributeDict["CurrencyCode"] ?? ""
            print("Currency code found: \(currentCurrencyCode)")
        }
    }

    // Collect character data for each relevant element
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        print("Found characters for element \(currentElement): \(trimmedString)")  // Element ve içeriği yazdır
        
        switch currentElement {
        case "ForexBuying":
            forexBuying = trimmedString
        case "ForexSelling":
            forexSelling = trimmedString
        case "BanknoteBuying":
            banknoteBuying = trimmedString
        case "BanknoteSelling":
            banknoteSelling = trimmedString
        case "CrossRateUSD":
            crossRateUSD = trimmedString
        default:
            break
        }
    }

    // At the end of a "Currency" element, update the static currency list with dynamic exchange rates
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Currency" {
            if let index = staticCurrencies.firstIndex(where: { $0.currencyCode == currentCurrencyCode }) {
                // Kurları güncelleyip loglayalım
                staticCurrencies[index].forexBuying = Double(forexBuying.replacingOccurrences(of: ",", with: ".")) ?? 1.0
                staticCurrencies[index].forexSelling = Double(forexSelling.replacingOccurrences(of: ",", with: ".")) ?? 1.0
                staticCurrencies[index].banknoteBuying = Double(banknoteBuying.replacingOccurrences(of: ",", with: ".")) ?? 1.0
                staticCurrencies[index].banknoteSelling = Double(banknoteSelling.replacingOccurrences(of: ",", with: ".")) ?? 1.0
                staticCurrencies[index].crossRateUSD = Double(crossRateUSD.replacingOccurrences(of: ",", with: ".")) ?? 1.0
                
                print("Updated rates for: \(currentCurrencyCode)")
            } else {
                print("Currency code not found in static list: \(currentCurrencyCode)")
            }

            // Reset for the next element
            forexBuying = ""
            forexSelling = ""
            banknoteBuying = ""
            banknoteSelling = ""
            crossRateUSD = ""
        }
    }

    // Currency conversion function considering CrossRateUSD for cross conversions
    func convertCurrency(amount: Double, fromCurrency: CurrencyRate, toCurrency: CurrencyRate) -> Double {
        print("Converting \(amount) from \(fromCurrency.currencyCode) to \(toCurrency.currencyCode)")

        // Case 1: If both currencies are TRY-related
        if fromCurrency.currencyCode == "TRY" {
            print("TRY to \(toCurrency.currencyCode) conversion: amount = \(amount), toRate = \(toCurrency.forexBuying ?? 1.0)")
            return amount / (toCurrency.forexBuying ?? 1.0)
        } else if toCurrency.currencyCode == "TRY" {
            print("\(fromCurrency.currencyCode) to TRY conversion: amount = \(amount), fromRate = \(fromCurrency.forexBuying ?? 1.0)")
            return amount * (fromCurrency.forexBuying ?? 1.0)
        }
        // Case 2: Cross conversion using USD as intermediary
        else {
            print("Cross conversion via USD: amount = \(amount), fromRateUSD = \(fromCurrency.crossRateUSD ?? 1.0), toRateUSD = \(toCurrency.crossRateUSD ?? 1.0)")
            let amountInUSD = amount / (fromCurrency.crossRateUSD ?? 1.0)
            return amountInUSD * (toCurrency.crossRateUSD ?? 1.0)
        }
    }
}
