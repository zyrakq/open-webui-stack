---
sidebar_position: 2
title: "🗨️ Openedai-speech Using Docker"
---

:::warning
This tutorial is a community contribution and is not supported by the Open WebUI team. It serves only as a demonstration on how to customize Open WebUI for your specific use case. Want to contribute? Check out the contributing tutorial.
:::

**Integrating `openedai-speech` into Open WebUI using Docker**
==============================================================

**What is `openedai-speech`?**
-----------------------------

:::info
[openedai-speech](https://github.com/matatonic/openedai-speech) is an OpenAI audio/speech API compatible text-to-speech server.

It serves the `/v1/audio/speech` endpoint and provides a free, private text-to-speech experience with custom voice cloning capabilities. This service is in no way affiliated with OpenAI and does not require an OpenAI API key.
:::

**Requirements**
-----------------

* Docker installed on your system
* Open WebUI running in a Docker container
* Basic understanding of Docker and Docker Compose

**Option 1: Using Docker Compose**
----------------------------------

**Step 1: Create a new folder for the `openedai-speech` service**
-----------------------------------------------------------------

Create a new folder, for example, `openedai-speech-service`, to store the `docker-compose.yml` and `speech.env` files.

**Step 2: Clone the `openedai-speech` repository from GitHub**
--------------------------------------------------------------

```bash
git clone https://github.com/matatonic/openedai-speech.git
```

This will download the `openedai-speech` repository to your local machine, which includes the Docker Compose files (`docker-compose.yml`, `docker-compose.min.yml`, and `docker-compose.rocm.yml`) and other necessary files.

**Step 3: Rename the `sample.env` file to `speech.env` (Customize if needed)**
------------------------------------------------------------------------------

In the `openedai-speech` repository folder, create a new file named `speech.env` with the following contents:

```yaml
TTS_HOME=voices
HF_HOME=voices
#PRELOAD_MODEL=xtts
#PRELOAD_MODEL=xtts_v2.0.2
#PRELOAD_MODEL=parler-tts/parler_tts_mini_v0.1
#EXTRA_ARGS=--log-level DEBUG --unload-timer 300
#USE_ROCM=1
```

**Step 4: Choose a Docker Compose file**
----------------------------------------

You can use any of the following Docker Compose files:

* [docker-compose.yml](https://github.com/matatonic/openedai-speech/blob/main/docker-compose.yml): This file uses the `ghcr.io/matatonic/openedai-speech` image and builds from [Dockerfile](https://github.com/matatonic/openedai-speech/blob/main/Dockerfile).
* [docker-compose.min.yml](https://github.com/matatonic/openedai-speech/blob/main/docker-compose.min.yml): This file uses the `ghcr.io/matatonic/openedai-speech-min` image and builds from [Dockerfile.min](https://github.com/matatonic/openedai-speech/blob/main/Dockerfile.min).
  This image is a minimal version that only includes Piper support and does not require a GPU.
* [docker-compose.rocm.yml](https://github.com/matatonic/openedai-speech/blob/main/docker-compose.rocm.yml): This file uses the `ghcr.io/matatonic/openedai-speech-rocm` image and builds from [Dockerfile](https://github.com/matatonic/openedai-speech/blob/main/Dockerfile) with ROCm support.

**Step 4: Build the Chosen Docker Image**
-----------------------------------------

Before running the Docker Compose file, you need to build the Docker image:

* **Nvidia GPU (CUDA support)**:

```bash
docker build -t ghcr.io/matatonic/openedai-speech .
```

* **AMD GPU (ROCm support)**:

```bash
docker build -f Dockerfile --build-arg USE_ROCM=1 -t ghcr.io/matatonic/openedai-speech-rocm .
```

* **CPU only, No GPU (Piper only)**:

```bash
docker build -f Dockerfile.min -t ghcr.io/matatonic/openedai-speech-min .
```

**Step 5: Run the correct `docker compose up -d` command**
----------------------------------------------------------

* **Nvidia GPU (CUDA support)**: Run the following command to start the `openedai-speech` service in detached mode:

```bash
docker compose up -d
```

* **AMD GPU (ROCm support)**: Run the following command to start the `openedai-speech` service in detached mode:

```bash
docker compose -f docker-compose.rocm.yml up -d
```

* **ARM64 (Apple M-series, Raspberry Pi)**: XTTS only has CPU support here and will be very slow. You can use the Nvidia image for XTTS with CPU (slow), or use the Piper only image (recommended):

```bash
docker compose -f docker-compose.min.yml up -d
```

* **CPU only, No GPU (Piper only)**: For a minimal docker image with only Piper support (< 1GB vs. 8GB):

```bash
docker compose -f docker-compose.min.yml up -d
```

This will start the `openedai-speech` service in detached mode.

**Option 2: Using Docker Run Commands**
---------------------------------------

You can also use the following Docker run commands to start the `openedai-speech` service in detached mode:

* **Nvidia GPU (CUDA)**: Run the following command to build and start the `openedai-speech` service:

```bash
docker build -t ghcr.io/matatonic/openedai-speech .
docker run -d --gpus=all -p 8000:8000 -v voices:/app/voices -v config:/app/config --name openedai-speech ghcr.io/matatonic/openedai-speech
```

* **ROCm (AMD GPU)**: Run the following command to build and start the `openedai-speech` service:

> To enable ROCm support, uncomment the `#USE_ROCM=1` line in the `speech.env` file.

```bash
docker build -f Dockerfile --build-arg USE_ROCM=1 -t ghcr.io/matatonic/openedai-speech-rocm .
docker run -d --privileged --init --name openedai-speech -p 8000:8000 -v voices:/app/voices -v config:/app/config ghcr.io/matatonic/openedai-speech-rocm
```

* **CPU only, No GPU (Piper only)**: Run the following command to build and start the `openedai-speech` service:

```bash
docker build -f Dockerfile.min -t ghcr.io/matatonic/openedai-speech-min .
docker run -d -p 8000:8000 -v voices:/app/voices -v config:/app/config --name openedai-speech ghcr.io/matatonic/openedai-speech-min
```

**Step 6: Configuring Open WebUI to use `openedai-speech` for TTS**
---------------------------------------------------------

![openedai-tts](https://github.com/silentoplayz/docs/assets/50341825/ea08494f-2ebf-41a2-bb0f-9b48dd3ace79)

Open the Open WebUI settings and navigate to the TTS Settings under **Admin Panel > Settings > Audio**. Add the following configuration:

* **API Base URL**: `http://host.docker.internal:8000/v1`
* **API Key**: `sk-111111111` (Note that this is a dummy API key, as `openedai-speech` doesn't require an API key. You can use whatever you'd like for this field, as long as it is filled.)

**Step 7: Choose a voice**
--------------------------

Under `TTS Voice` within the same audio settings menu in the admin panel, you can set the `TTS Model` to use from the following choices below that `openedai-speech` supports. The voices of these models are optimized for the English language.

* `tts-1` or `tts-1-hd`: `alloy`, `echo`, `echo-alt`, `fable`, `onyx`, `nova`, and `shimmer` (`tts-1-hd` is configurable; uses OpenAI samples by default)

**Step 8: Press `Save` to apply the changes and start enjoying naturally sounding voices**
--------------------------------------------------------------------------------------------

Press the `Save` button to apply the changes to your Open WebUI settings. Refresh the page for the change to fully take effect and enjoy using `openedai-speech` integration within Open WebUI to read aloud text responses with text-to-speech in a natural sounding voice.

**Model Details:**
------------------

`openedai-speech` supports multiple text-to-speech models, each with its own strengths and requirements. The following models are available:

* **Piper TTS** (very fast, runs on CPU): Use your own [Piper voices](https://rhasspy.github.io/piper-samples/) via the `voice_to_speaker.yaml` configuration file. This model is great for applications that require low latency and high performance. Piper TTS also supports [multilingual](https://github.com/matatonic/openedai-speech#multilingual) voices.
* **Coqui AI/TTS XTTS v2** (fast, but requires around 4GB GPU VRAM & Nvidia GPU with CUDA): This model uses Coqui AI's XTTS v2 voice cloning technology to generate high-quality voices. While it requires a more powerful GPU, it provides excellent performance and high-quality audio. Coqui also supports [multilingual](https://github.com/matatonic/openedai-speech#multilingual) voices.
* **Beta Parler-TTS Support** (experimental, slower): This model uses the Parler-TTS framework to generate voices. While it's currently in beta, it allows you to describe very basic features of the speaker voice. The exact voice will be slightly different with each generation, but should be similar to the speaker description provided. For inspiration on how to describe voices, see [Text Description to Speech](https://www.text-description-to-speech.com/).

**Troubleshooting**
-------------------

If you encounter any problems integrating `openedai-speech` with Open WebUI, follow these troubleshooting steps:

* **Verify `openedai-speech` service**: Ensure that the `openedai-speech` service is running and the port you specified in the docker-compose.yml file is exposed.
* **Check access to host.docker.internal**: Verify that the hostname `host.docker.internal` is resolvable from within the Open WebUI container. This is necessary because `openedai-speech` is exposed via `localhost` on your PC, but `open-webui` cannot normally access it from inside its container. You can add a volume to the `docker-compose.yml` file to mount a file from the host to the container, for example, to a directory that will be served by openedai-speech.
* **Review API key configuration**: Make sure the API key is set to a dummy value or effectively left unchecked because `openedai-speech` doesn't require an API key.
* **Check voice configuration**: Verify that the voice you are trying to use for TTS exists in your `voice_to_speaker.yaml` file and the corresponding files (e.g., voice XML files) are present in the correct directory.
* **Verify voice model paths**: If you're experiencing issues with voice model loading, double-check that the paths in your `voice_to_speaker.yaml` file match the actual locations of your voice models.

**Additional Troubleshooting Tips**
------------------------------------

* Check the openedai-speech logs for errors or warnings that might indicate where the issue lies.
* Verify that the `docker-compose.yml` file is correctly configured for your environment.
* If you're still experiencing issues, try restarting the `openedai-speech` service or the entire Docker environment.
* If the problem persists, consult the `openedai-speech` GitHub repository or seek help on a relevant community forum.

**FAQ**
-------

**How can I control the emotional range of the generated audio?**

There is no direct mechanism to control the emotional output of the generated audio. Certain factors such as capitalization or grammar may affect the output audio, but internal testing has yielded mixed results.

**Where are the voice files stored? What about the configuration file?**.

The configuration files, which define the available voices and their properties, are stored in the config volume. Specifically, the default voices are defined in voice_to_speaker.default.yaml.

**Additional Resources**
------------------------

For more information on configuring Open WebUI to use `openedai-speech`, including setting environment variables, see the [Open WebUI documentation](https://docs.openwebui.com/getting-started/env-configuration#text-to-speech).

For more information about `openedai-speech`, please visit the [GitHub repository](https://github.com/matatonic/openedai-speech).

**How to add more voices to openedai-speech:**
[Custom-Voices-HowTo](https://github.com/matatonic/openedai-speech?tab=readme-ov-file#custom-voices-howto)

:::note
You can change the port number in the `docker-compose.yml` file to any open and usable port, but be sure to update the **API Base URL** in Open WebUI Admin Audio settings accordingly.
:::


---


# OpenedAI Speech

Notice: This software is mostly obsolete and will no longer be updated.

Some Alternatives:

* https://speaches.ai/
* https://github.com/remsky/Kokoro-FastAPI
* https://github.com/astramind-ai/Auralis
* https://lightning.ai/docs/litserve/home?code_sample=speech

----

An OpenAI API compatible text to speech server.

* Compatible with the OpenAI audio/speech API
* Serves the [/v1/audio/speech endpoint](https://platform.openai.com/docs/api-reference/audio/createSpeech)
* Not affiliated with OpenAI in any way, does not require an OpenAI API Key
* A free, private, text-to-speech server with custom voice cloning

Full Compatibility:
* `tts-1`: `alloy`, `echo`, `fable`, `onyx`, `nova`, and `shimmer` (configurable)
* `tts-1-hd`:  `alloy`, `echo`, `fable`, `onyx`, `nova`, and `shimmer` (configurable, uses OpenAI samples by default)
* response_format: `mp3`, `opus`, `aac`, `flac`, `wav` and `pcm`
* speed 0.25-4.0 (and more)

Details:
* Model `tts-1` via [piper tts](https://github.com/rhasspy/piper) (very fast, runs on cpu)
  * You can map your own [piper voices](https://rhasspy.github.io/piper-samples/) via the `voice_to_speaker.yaml` configuration file
* Model `tts-1-hd` via [coqui-ai/TTS](https://github.com/coqui-ai/TTS) xtts_v2 voice cloning (fast, but requires around 4GB GPU VRAM)
  * Custom cloned voices can be used for tts-1-hd, See: [Custom Voices Howto](#custom-voices-howto)
  * 🌐 [Multilingual](#multilingual) support with XTTS voices, the language is automatically detected if not set
  * [Custom fine-tuned XTTS model support](#custom-fine-tuned-model-support)
  * Configurable [generation parameters](#generation-parameters)
  * Streamed output while generating
* Occasionally, certain words or symbols may sound incorrect, you can fix them with regex via `pre_process_map.yaml`
* Tested with python 3.9-3.11, piper does not install on python 3.12 yet


If you find a better voice match for `tts-1` or `tts-1-hd`, please let me know so I can update the defaults.

## Recent Changes

Version 0.18.2, 2024-08-16

* Fix docker building for amd64, refactor github actions again, free up more disk space

Version 0.18.1, 2024-08-15

* refactor github actions

Version 0.18.0, 2024-08-15

* Allow folders of wav samples in xtts. Samples will be combined, allowing for mixed voices and collections of small samples. Still limited to 30 seconds total. Thanks @nathanhere.
* Fix missing yaml requirement in -min image
* fix fr_FR-tom-medium and other 44khz piper voices (detect non-default sample rates)
* minor updates

Version 0.17.2, 2024-07-01

* fix -min image (re: langdetect)

Version 0.17.1, 2024-07-01

* fix ROCm (add langdetect to requirements-rocm.txt)
* Fix zh-cn for xtts

Version 0.17.0, 2024-07-01

* Automatic language detection, thanks [@RodolfoCastanheira](https://github.com/RodolfoCastanheira)

Version 0.16.0, 2024-06-29

* Multi-client safe version. Audio generation is synchronized in a single process. The estimated 'realtime' factor of XTTS on a GPU is roughly 1/3, this means that multiple streams simultaneously, or `speed` over 2, may experience audio underrun (delays or pauses in playback). This makes multiple clients possible and safe, but in practice 2 or 3 simultaneous streams is the maximum without audio underrun.

Version 0.15.1, 2024-06-27

* Remove deepspeed from requirements.txt, it's too complex for typical users. A more detailed deepspeed install document will be required.

Version 0.15.0, 2024-06-26

* Switch to [coqui-tts](https://github.com/idiap/coqui-ai-TTS) (updated fork), updated simpler dependencies, torch 2.3, etc.
* Resolve cuda threading issues

Version 0.14.1, 2024-06-26

* Make deepspeed possible (`--use-deepspeed`), but not enabled in pre-built docker images (too large). Requires the cuda-toolkit installed, see the Dockerfile comment for details

Version 0.14.0, 2024-06-26

* Added `response_format`: `wav` and `pcm` support
* Output streaming (while generating) for `tts-1` and `tts-1-hd`
* Enhanced [generation parameters](#generation-parameters) for xtts models (temperature, top_p, etc.)
* Idle unload timer (optional) - doesn't work perfectly yet
* Improved error handling

Version 0.13.0, 2024-06-25

* Added [Custom fine-tuned XTTS model support](#custom-fine-tuned-model-support)
* Initial prebuilt arm64 image support (Apple M-series, Raspberry Pi - MPS is not supported in XTTS/torch), thanks [@JakeStevenson](https://github.com/JakeStevenson), [@hchasens](https://github.com/hchasens)
* Initial attempt at AMD GPU (ROCm 5.7) support
* Parler-tts support removed
* Move the *.default.yaml to the root folder
* Run the docker as a service by default (`restart: unless-stopped`)
* Added `audio_reader.py` for streaming text input and reading long texts

Version 0.12.3, 2024-06-17

* Additional logging details for BadRequests (400)

Version 0.12.2, 2024-06-16

* Fix :min image requirements (numpy<2?)

Version 0.12.0, 2024-06-16

* Improved error handling and logging
* Restore the original alloy tts-1-hd voice by default, use alloy-alt for the old voice.

Version 0.11.0, 2024-05-29

* 🌐 [Multilingual](#multilingual) support (16 languages) with XTTS
* Remove high Unicode filtering from the default `config/pre_process_map.yaml`
* Update Docker build & app startup. thanks @justinh-rahb
* Fix: "Plan failed with a cudnnException"
* Remove piper cuda support

Version: 0.10.1, 2024-05-05

* Remove `runtime: nvidia` from docker-compose.yml, this assumes nvidia/cuda compatible runtime is available by default. thanks [@jmtatsch](https://github.com/jmtatsch)

Version: 0.10.0, 2024-04-27

* Pre-built & tested docker images, smaller docker images (8GB or 860MB)
* Better upgrades: reorganize config files under `config/`, voice models under `voices/`
* **Compatibility!** If you customized your `voice_to_speaker.yaml` or `pre_process_map.yaml` you need to move them to the `config/` folder.
* default listen host to 0.0.0.0

Version: 0.9.0, 2024-04-23

* Fix bug with yaml and loading UTF-8
* New sample text-to-speech application `say.py`
* Smaller docker base image
* Add beta [parler-tts](https://huggingface.co/parler-tts/parler_tts_mini_v0.1) support (you can describe very basic features of the speaker voice), See: (https://www.text-description-to-speech.com/) for some examples of how to describe voices. Voices can be defined in the `voice_to_speaker.default.yaml`. Two example [parler-tts](https://huggingface.co/parler-tts/parler_tts_mini_v0.1) voices are included in the `voice_to_speaker.default.yaml` file. `parler-tts` is experimental software and is kind of slow. The exact voice will be slightly different each generation but should be similar to the basic description.

...

Version: 0.7.3, 2024-03-20

* Allow different xtts versions per voice in `voice_to_speaker.yaml`, ex. xtts_v2.0.2
* Quality: Fix xtts sample rate (24000 vs. 22050 for piper) and pops


## Installation instructions

### Create a `speech.env` environment file

Copy the `sample.env` to `speech.env` (customize if needed)
```bash
cp sample.env speech.env
```

#### Defaults
```bash
TTS_HOME=voices
HF_HOME=voices
#PRELOAD_MODEL=xtts
#PRELOAD_MODEL=xtts_v2.0.2
#EXTRA_ARGS=--log-level DEBUG --unload-timer 300
#USE_ROCM=1
```

### Option A: Manual installation
```shell
# install curl and ffmpeg
sudo apt install curl ffmpeg
# Create & activate a new virtual environment (optional but recommended)
python -m venv .venv
source .venv/bin/activate
# Install the Python requirements
# - use requirements-rocm.txt for AMD GPU (ROCm support)
# - use requirements-min.txt for piper only (CPU only)
pip install -U -r requirements.txt
# run the server
bash startup.sh
```

> On first run, the voice models will be downloaded automatically. This might take a while depending on your network connection.

### Option B: Docker Image (*recommended*)

#### Nvidia GPU (cuda)

```shell
docker compose up
```

#### AMD GPU (ROCm support)

```shell
docker compose -f docker-compose.rocm.yml up
```

#### ARM64 (Apple M-series, Raspberry Pi)

> XTTS only has CPU support here and will be very slow, you can use the Nvidia image for XTTS with CPU (slow), or use the piper only image (recommended)

#### CPU only, No GPU (piper only)

> For a minimal docker image with only piper support (<1GB vs. 8GB).

```shell
docker compose -f docker-compose.min.yml up
```

## Server Options

```shell
usage: speech.py [-h] [--xtts_device XTTS_DEVICE] [--preload PRELOAD] [--unload-timer UNLOAD_TIMER] [--use-deepspeed] [--no-cache-speaker] [-P PORT] [-H HOST]
                 [-L {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

OpenedAI Speech API Server

options:
  -h, --help            show this help message and exit
  --xtts_device XTTS_DEVICE
                        Set the device for the xtts model. The special value of 'none' will use piper for all models. (default: cuda)
  --preload PRELOAD     Preload a model (Ex. 'xtts' or 'xtts_v2.0.2'). By default it's loaded on first use. (default: None)
  --unload-timer UNLOAD_TIMER
                        Idle unload timer for the XTTS model in seconds, Ex. 900 for 15 minutes (default: None)
  --use-deepspeed       Use deepspeed with xtts (this option is unsupported) (default: False)
  --no-cache-speaker    Don't use the speaker wav embeddings cache (default: False)
  -P PORT, --port PORT  Server tcp port (default: 8000)
  -H HOST, --host HOST  Host to listen on, Ex. 0.0.0.0 (default: 0.0.0.0)
  -L {DEBUG,INFO,WARNING,ERROR,CRITICAL}, --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the log level (default: INFO)
```


## Sample Usage

You can use it like this:

```shell
curl http://localhost:8000/v1/audio/speech -H "Content-Type: application/json" -d '{
    "model": "tts-1",
    "input": "The quick brown fox jumped over the lazy dog.",
    "voice": "alloy",
    "response_format": "mp3",
    "speed": 1.0
  }' > speech.mp3
```

Or just like this:

```shell
curl -s http://localhost:8000/v1/audio/speech -H "Content-Type: application/json" -d '{
    "input": "The quick brown fox jumped over the lazy dog."}' > speech.mp3
```

Or like this example from the [OpenAI Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech):

```python
import openai

client = openai.OpenAI(
  # This part is not needed if you set these environment variables before import openai
  # export OPENAI_API_KEY=sk-11111111111
  # export OPENAI_BASE_URL=http://localhost:8000/v1
  api_key = "sk-111111111",
  base_url = "http://localhost:8000/v1",
)

with client.audio.speech.with_streaming_response.create(
  model="tts-1",
  voice="alloy",
  input="Today is a wonderful day to build something people love!"
) as response:
  response.stream_to_file("speech.mp3")
```

Also see the `say.py` sample application for an example of how to use the openai-python API.

```shell
# play the audio, requires 'pip install playsound'
python say.py -t "The quick brown fox jumped over the lazy dog." -p
# save to a file in flac format
python say.py -t "The quick brown fox jumped over the lazy dog." -m tts-1-hd -v onyx -f flac -o fox.flac
```

You can also try the included `audio_reader.py` for listening to longer text and streamed input.

Example usage:
```bash
python audio_reader.py -s 2 < LICENSE # read the software license - fast
```

## OpenAI API Documentation and Guide

* [OpenAI Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech)
* [OpenAI API Reference](https://platform.openai.com/docs/api-reference/audio/createSpeech)


## Custom Voices Howto

### Piper

  1. Select the piper voice and model from the [piper samples](https://rhasspy.github.io/piper-samples/)
  2. Update the `config/voice_to_speaker.yaml` with a new section for the voice, for example:
```yaml
...
tts-1:
  ryan:
    model: voices/en_US-ryan-high.onnx
    speaker: # default speaker
```
  3. New models will be downloaded as needed, of you can download them in advance with `download_voices_tts-1.sh`. For example:
```shell
bash download_voices_tts-1.sh en_US-ryan-high
```

### Coqui XTTS v2

Coqui XTTS v2 voice cloning can work with as little as 6 seconds of clear audio. To create a custom voice clone, you must prepare a WAV file sample of the voice.

#### Guidelines for preparing good sample files for Coqui XTTS v2
* Mono (single channel) 22050 Hz WAV file
* 6-30 seconds long - longer isn't always better (I've had some good results with as little as 4 seconds)
* low noise (no hiss or hum)
* No partial words, breathing, laughing, music or backgrounds sounds
* An even speaking pace with a variety of words is best, like in interviews or audiobooks.
* Audio longer than 30 seconds will be silently truncated.

You can use FFmpeg to prepare your audio files, here are some examples:

```shell
# convert a multi-channel audio file to mono, set sample rate to 22050 hz, trim to 6 seconds, and output as WAV file.
ffmpeg -i input.mp3 -ac 1 -ar 22050 -t 6 -y me.wav
# use a simple noise filter to clean up audio, and select a start time start for sampling.
ffmpeg -i input.wav -af "highpass=f=200, lowpass=f=3000" -ac 1 -ar 22050 -ss 00:13:26.2 -t 6 -y me.wav
# A more complex noise reduction setup, including volume adjustment
ffmpeg -i input.mkv -af "highpass=f=200, lowpass=f=3000, volume=5, afftdn=nf=25" -ac 1 -ar 22050 -ss 00:13:26.2 -t 6 -y me.wav
```

Once your WAV file is prepared, save it in the `/voices/` directory and update the `config/voice_to_speaker.yaml` file with the new file name.

For example:

```yaml
...
tts-1-hd:
  me:
    model: xtts
    speaker: voices/me.wav # this could be you
```

You can also use a sub folder for multiple audio samples to combine small samples or to mix different samples together.

For example:

```yaml
...
tts-1-hd:
  mixed:
    model: xtts
    speaker: voices/mixed
```

Where the `voices/mixed/` folder contains multiple wav files. The total audio length is still limited to 30 seconds.

## Multilingual

Multilingual cloning support was added in version 0.11.0 and is available only with the XTTS v2 model. To use multilingual voices with piper simply download a language specific voice.

Coqui XTTSv2 has support for multiple languages: English (`en`), Spanish (`es`), French (`fr`), German (`de`), Italian (`it`), Portuguese (`pt`), Polish (`pl`), Turkish (`tr`), Russian (`ru`), Dutch (`nl`), Czech (`cs`), Arabic (`ar`), Chinese (`zh-cn`), Hungarian (`hu`), Korean (`ko`), Japanese (`ja`), and Hindi (`hi`). When not set, an attempt will be made to automatically detect the language, falling back to English (`en`).

Unfortunately the OpenAI API does not support language, but you can create your own custom speaker voice and set the language for that.

1) Create the WAV file for your speaker, as in [Custom Voices Howto](#custom-voices-howto)
2) Add the voice to `config/voice_to_speaker.yaml` and include the correct Coqui `language` code for the speaker. For example:

```yaml
  xunjiang:
    model: xtts
    speaker: voices/xunjiang.wav
    language: zh-cn
```

3) Don't remove high unicode characters in your `config/pre_process_map.yaml`! If you have these lines, you will need to remove them. For example:

Remove:
```yaml
- - '[\U0001F600-\U0001F64F\U0001F300-\U0001F5FF\U0001F680-\U0001F6FF\U0001F700-\U0001F77F\U0001F780-\U0001F7FF\U0001F800-\U0001F8FF\U0001F900-\U0001F9FF\U0001FA00-\U0001FA6F\U0001FA70-\U0001FAFF\U00002702-\U000027B0\U000024C2-\U0001F251]+'
  - ''
```

These lines were added to the `config/pre_process_map.yaml` config file by default before version 0.11.0:

4) Your new multi-lingual speaker voice is ready to use!


## Custom Fine-Tuned Model Support

Adding a custom xtts model is simple. Here is an example of how to add a custom fine-tuned 'halo' XTTS model.

1) Save the model folder under `voices/` (all 4 files are required, including the vocab.json from the model)
```
openedai-speech$ ls voices/halo/
config.json  vocab.json  model.pth  sample.wav
```
2) Add the custom voice entry under the `tts-1-hd` section of `config/voice_to_speaker.yaml`:
```yaml
tts-1-hd:
...
  halo:
    model: halo # This name is required to be unique
    speaker: voices/halo/sample.wav # voice sample is required
    model_path: voices/halo
```
3) The model will be loaded when you access the voice for the first time (`--preload` doesn't work with custom models yet)

## Generation Parameters

The generation of XTTSv2 voices can be fine tuned with the following options (defaults included below):

```yaml
tts-1-hd:
  alloy:
    model: xtts
    speaker: voices/alloy.wav
    enable_text_splitting: True
    length_penalty: 1.0
    repetition_penalty: 10
    speed: 1.0
    temperature: 0.75
    top_k: 50
    top_p: 0.85
```