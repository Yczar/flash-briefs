# Flash Briefs

Flash Briefs is an innovative application leveraging Google's Generative AI(Gemini) to provide concise, accurate summaries of lengthy text content. Designed to enhance productivity and information absorption, Flash Brief aims to transform the way users interact with digital content, making it easier to consume large volumes of information quickly and efficiently.

![RPReplay_Final1707975915](https://github.com/Yczar/flash-briefs/assets/32166619/1a0ada93-9b97-405a-99f7-c60bed135a39)

## Features

- **AI-Powered Summaries**: Utilizes the latest advancements in Google's Generative AI to generate precise summaries.
- **User-Friendly Interface**: A clean, intuitive interface allows for easy navigation and operation.

## Getting Started

### API keys

To run the app, you'll need a Gemini API key. If you don't already have one,
create a key in Google AI Studio: https://makersuite.google.com/app/apikey.

You will also need a News API key. If you don't already have one, create one here:
https://newsapi.org/

### Prerequisites

- Ensure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- An active internet connection for accessing Google's Generative AI APIs.

### Steps

1. **Clone the Repository**

   First, clone this repository to your local machine using Git.

   ```bash
   git clone https://github.com/Yczar/flash-briefs.git
   cd flash-briefs
   ```

2. **Install Dependencies**

   Navigate to the project directory and run the following command to install the necessary Flutter dependencies:

   ```bash
   flutter pub get
   ```

3. **Run the App**

   Ensure an emulator is running or a device is connected to your computer. You can check connected devices with:

   ```bash
   flutter devices
   ```

   Then, execute the following command to run the app:

   ```bash
   flutter run --dart-define=newsAPIKey=NEWS_API_KEY --dart-define=geminiAPIKey=GEMINI_API_KEY
   ```

## Using the App

Provide instructions specific to your app that users need to know to get started using it. This could include how to navigate the app, any login instructions, or how to use key features.

## Contributing

We welcome contributions to improve this project. Please follow these steps to contribute:

1. Fork the repository.
2. Create a branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```

```
