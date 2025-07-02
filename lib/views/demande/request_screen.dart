import 'package:flutter/material.dart';
import 'package:my_clean_city/core/services/database_service.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/form_custom.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:my_clean_city/widgets/text_field_custom.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final key = GlobalKey<FormState>();
  final _adresseController = TextEditingController();
  final _phoneController = TextEditingController();
  final _quantiteController = TextEditingController();

  DatabaseService databaseService = DatabaseService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Demande de collecte',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormCustom(
                formKey: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      data: 'Entrer votre adresse',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.0),
                    TextFieldCustom(
                      labelText: 'Adresse',
                      prefixIcon: Icon(Icons.location_on, color: Colors.green),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre adresse';
                        }
                        return null;
                      },
                      controller: _adresseController,
                    ),
                    SizedBox(height: 40.0),
                    TextCustom(
                      data: 'Entrer votre numèro de téléphone',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.0),
                    TextFieldCustom(
                      labelText: 'Numéro de téléphone',
                      textInputType: TextInputType.phone,
                      prefixIcon: Icon(Icons.phone, color: Colors.green),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre numéro de téléphone';
                        }
                        return null;
                      },
                      controller: _phoneController,
                    ),
                    SizedBox(height: 40.0),
                    TextCustom(
                      data: 'Entrer la quantité de l\' élément à collecter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.0),
                    TextFieldCustom(
                      labelText: 'quantité',
                      prefixIcon: Icon(Icons.recycling, color: Colors.green),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la quantité à collecter';
                        } else {
                          return null;
                        }
                      },
                      controller: _quantiteController,
                    ),
                  ],
                ),
              ),
              Spacer(),
              ButtonCustom(
                onTap: () {
                  if (key.currentState!.validate()) {
                    databaseService
                        .addRequest(
                          adresse: _adresseController.text,
                          phone: _phoneController.text,
                          quantite: _quantiteController.text,
                        )
                        .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Demande envoyée avec succès'),
                            ),
                          );
                          Navigator.pop(context);
                        })
                        .catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                              content: Text('Erreur lors de l\'envoi'),
                            ),
                          );
                        });
                  }
                },
                child: Center(
                  child: TextCustom(
                    data: 'Upload',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
