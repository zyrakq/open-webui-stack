# 🎵 OpenedAI Speech Integration

This project provides `openedai-speech` integration with NVIDIA GPU support and custom voices.

## ⚙️ Configuration

Update the `config/voice_to_speaker.yaml` file by adding paths to your audio files.

## 🚀 Running

To start the service, use the command:

```bash
docker-compose up -d
```

The service will be available at `http://localhost:8000`.

## 🖥️ NVIDIA GPU Connection

To use NVIDIA GPU, make sure you have [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) installed. GPU configuration is already included in `docker-compose.yml`.

## 📝 Usage Example

Example request for speech generation:

```bash
curl -X POST http://localhost:8000/v1/audio/speech \
  -H "Content-Type: application/json" \
  -d '{
    "input": "Example text for text-to-speech conversion.",
    "voice": "custom_voice_1",
    "response_format": "mp3"
  }' --output speech.mp3
