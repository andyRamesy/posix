import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print("error on check biometrics : $e");
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType>? availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print("error on get available biometrics : $e");
    }
    if (!mounted) return;
    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = "Authenticating";
      });
      authenticated = await auth.authenticate(
        localizedReason: "The OS choose auth method",
        options: const AuthenticationOptions(stickyAuth: true),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print("authenticate has error: $e");
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) return;

    setState(
        () => _authorized = authenticated ? 'Authorized' : "not Authorized");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              if (_supportState == _SupportState.unknown)
                CircularProgressIndicator()
              else if (_supportState == _SupportState.supported)
                const Text('This is supported')
              else
                const Text('This is not supported'),
              const Divider(height: 100),
              Text('Can check biometrics: $_canCheckBiometrics\n'),
              ElevatedButton(
                onPressed: _checkBiometrics,
                child: const Text('Check biometrics'),
              ),
              const Divider(height: 100),
              Text('Available biometrics: $_availableBiometrics\n'),
              ElevatedButton(
                onPressed: _getAvailableBiometrics,
                child: const Text('Get available biometrics'),
              ),
              const Divider(height: 100),
              Text('Current State: $_authorized\n'),
              if (_isAuthenticating)
                ElevatedButton(
                    onPressed: () {},
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(_isAuthenticating ? 'Cancel' : 'Authenticate'),
                    ]))
              else
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _authenticate,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Authenticate'),
                          Icon(Icons.perm_device_information),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
