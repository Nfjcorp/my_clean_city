/* Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('assets/images/forgot_password.jpg'),
            SizedBox(height: 30),
            TextCustom(
              data: 'Create New Password',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            Center(
              child: TextCustom(
                data:
                    'your new password must be different from previous used password',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.0),
            FormCustom(
              formKey: formKey,
              child: Column(
                children: [
                  TextFieldCustom(
                    obscureText: isTrue,
                    controller: passwordController,
                    labelText: 'Enter Your Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isTrue = !isTrue;
                        });
                      },
                      icon:
                          isTrue
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your password';
                      } else if (value.length < 8) {
                        return 'password must be at least 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFieldCustom(
                    controller: confrimPassword,
                    labelText: 'Confirm Your Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isTrue = !isTrue;
                        });
                      },
                      icon:
                          isTrue
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your password';
                      } else if (value.length < 8) {
                        return 'password must be at least 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 30),
                  ButtonCustom(
                    onTap: () {},
                    child: Center(
                      child: TextCustom(
                        data: 'Create',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ); 
    
    
    
    





Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TitleButton(
                onTap: () {
                  return showDialogBox(
                    context,
                    'Déconnexion',
                    'Etes-vous sure de vouloir vous déconnecter',
                    hello,
                  );
                },
                leading: Icon(Icons.logout, color: Colors.red),
                title: TextCustom(
                  data: 'Se déconnecter',
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
















              CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Settings'),
              centerTitle: true,
            ),
          ),
          SliverAppBar(pinned: true),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              TitleButton(
                leading: Icon(Icons.lock_outline_sharp),
                title: TextCustom(
                  data: 'Politique de confidentialité',
                  fontSize: 16,
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
              ),
              SizedBox(height: 10.0),
              TitleButton(
                leading: Icon(Icons.help_outline),
                title: TextCustom(data: 'Centre d\'aide', fontSize: 16),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
              ),
              SizedBox(height: 10.0),
              TitleButton(
                leading: Icon(Icons.notifications_none_sharp),
                title: TextCustom(data: 'Notifications', fontSize: 16),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
              ),
            ]),
          ),
        ],
      ),
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    */