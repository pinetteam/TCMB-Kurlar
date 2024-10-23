import SwiftUI

struct ContentView: View {
    @State private var amountFrom: String = "" // İlk yazım alanı (From)
    @State private var amountTo: String = "" // İkinci yazım alanı (To)
    @State private var selectedCurrencyFrom: String = "USD" // Varsayılan başlangıç
    @State private var selectedCurrencyTo: String = "TRY" // Varsayılan başlangıç
    @State private var exchangeRates: [CurrencyRate] = []

    let tcmbService = TCMBService()

    var body: some View {
        VStack(spacing: 20) {
            Text("Currency Converter")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()

            // Üst döviz çevirme kutusu
            HStack {
                // Miktar girme alanı (amountFrom)
                TextField("Enter amount", text: $amountFrom)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.decimalPad)

                // Kaynak döviz seçimi (selectedCurrencyFrom)
                Picker("From", selection: $selectedCurrencyFrom) {
                    ForEach(exchangeRates, id: \.currencyCode) { rate in
                        Text(rate.getLocalizedCurrencyName()).tag(rate.currencyCode)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 100)
            }

            // Swap ikonu (Döviz değiştirme)
            Button(action: {
                swapCurrencies()
            }) {
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding()

            // Alt döviz çevirme kutusu
            HStack {
                // Hedef döviz seçimi (selectedCurrencyTo)
                Picker("To", selection: $selectedCurrencyTo) {
                    ForEach(exchangeRates, id: \.currencyCode) { rate in
                        Text(rate.getLocalizedCurrencyName()).tag(rate.currencyCode)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 100)

                // Hedef döviz miktarı (amountTo)
                TextField("Result", text: $amountTo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.decimalPad)
                    .disabled(true) // Sonuç alanı değiştirilemez, sadece gösterim amaçlı
            }

            // Dönüştür butonu
            Button(action: {
                convertCurrency()
            }) {
                Text("Convert")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(width: 200)
            }
            .padding()

            Spacer()
        }
        .padding()
        .onAppear {
            tcmbService.fetchExchangeRates { rates in
                self.exchangeRates = rates
            }
        }
    }

    // Döviz çevirme işlemi
    func convertCurrency() {
        guard let amountValue = Double(amountFrom),
              let fromRate = exchangeRates.first(where: { $0.currencyCode == selectedCurrencyFrom }),
              let toRate = exchangeRates.first(where: { $0.currencyCode == selectedCurrencyTo }) else {
            amountTo = "Invalid input or currency code"
            return
        }

        // Kullanıcı yukarıya miktar girerse aşağıda döviz dönüşümünü yapar
        let convertedAmount = tcmbService.convertCurrency(amount: amountValue, fromCurrency: fromRate, toCurrency: toRate)
        amountTo = String(format: "%.2f", convertedAmount)
    }

    // Döviz değiştirme işlemi (Swap)
    func swapCurrencies() {
        let tempCurrency = selectedCurrencyFrom
        selectedCurrencyFrom = selectedCurrencyTo
        selectedCurrencyTo = tempCurrency
        
        // Girilen miktarı ters çevirerek tekrar hesaplama
        if let amountValue = Double(amountFrom),
           let fromRate = exchangeRates.first(where: { $0.currencyCode == selectedCurrencyFrom }),
           let toRate = exchangeRates.first(where: { $0.currencyCode == selectedCurrencyTo }) {
            let convertedAmount = tcmbService.convertCurrency(amount: amountValue, fromCurrency: fromRate, toCurrency: toRate)
            amountTo = String(format: "%.2f", convertedAmount)
        }
    }
}

#Preview {
    ContentView()
}
