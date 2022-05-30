# ServerMonitor
REST API Script to monitor server availability

This Bash-Script monitors the server response by getting the HTTP Code through a cURL library. 
The Output Response will be displayed both in console and in an appender file named monitor_log.txt.

## Run Locally
Clone the project

```bash
  git clone https://github.com/TheDaVinciCodes/ServerMonitor.git
```

Go to the project directory

```bash
  cd ServerMonitor
```

Run on CMD

```bash
  ./server_monitor_args.sh <url> <seconds to sleep>
```

exemple: 

```bash
  ./server_monitor_v2.sh https://www.google.com/ 2
```

## Author
[@TheDaVinciCodes](https://github.com/TheDaVinciCodes)
