# Flutter Networking DI Samples

Demonstration DI approach using different network modules. 

## Code generation

[Auto_route](https://pub.dev/packages/auto_route) is used for easy navigation.  
[Freezed](https://pub.dev/packages/freezed) allows to quickly define "models".  
In order to generate necessary files run 

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```
## Server

As a [backend](https://github.com/Wellers0n/Backend-diff) we used an open source project with minor changes. 

## Start Client

### Running on an Emulator

First, you must find out the IPv4 address of your computer.  
Open terminal and use  

```
ipconfig
```
After running this command, you'll need to copy the IPv4 address to [client/lib/domain/constants/connectivity_constants.dart](./client/lib/domain/constants/connectivity_constants.dart) into `_baseDomain` variable. 
Don`t change port.

#### Network module selection

Our app implements the following network approaches:

- Http
- Dio
- GraphQL

`--dart-define` is used to choose the specific approach (default one is http).  

To start the client:

```
cd grpc_flutter_client && flutter run --dart-define NETWORK_MODULE=chosen approach(http, dio or graphql)
```
### Running on a Device

In order to run on a real device, you must use [ngrok](https://ngrok.com). Ngrok is a globally distributed reverse proxy fronting your web services running in any cloud or private network, or your machine (enough a free ngrok account).  

For both Http and Dio:
```
ngrok tcp 5001
```

For GraphQL:
```
ngrok tcp 5000
```
Now you need to copy the `Forwarding` address (both host and port) to [client/lib/domain/constants/connectivity_constants.dart](client/lib/domain/constants/connectivity_constants.dart).
