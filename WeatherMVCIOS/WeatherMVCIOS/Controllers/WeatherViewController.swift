//
//  ViewController.swift
//  WeatherMVCIOS
//
//  Created by Evseev George on 13.03.25.
//

import UIKit

// MARK: - Weather View Controller
class WeatherViewController: UIViewController {
    private let weatherService: WeatherService
    private let cities = ["Tbilisi", "Batumi"]
    private var selectedCity = "Tbilisi"
    
    // MARK: - UI Elements
    private let cityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let citySegmentedControl = UISegmentedControl(items: ["Tbilisi", "Batumi"])
    
    // MARK: - Initializer with DI
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWeather()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .white
        
        cityLabel.text = selectedCity
        cityLabel.textAlignment = .center
        
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        descriptionLabel.textAlignment = .center
        
        citySegmentedControl.selectedSegmentIndex = 0
        citySegmentedControl.addTarget(self, action: #selector(cityChanged), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [citySegmentedControl, cityLabel, temperatureLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func cityChanged() {
        selectedCity = cities[citySegmentedControl.selectedSegmentIndex]
        cityLabel.text = selectedCity
        loadWeather()
    }
    
    private func loadWeather() {
        weatherService.fetchWeather(for: selectedCity) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.temperatureLabel.text = "Temperature: \(String(format: "%.1f", weatherData.main.temp))°C"
                self?.descriptionLabel.text = weatherData.weather.first?.description.capitalized
            case .failure(let error):
                self?.temperatureLabel.text = "Error: \(error.localizedDescription)"
            }
        }
    }
}

