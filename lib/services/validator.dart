class Validator{
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required';
    }
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required';
    }
    if(value.length < 6){
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateName(String? value){
    if(value == null || value.isEmpty){
      return 'Name is required';
    }
    if(value.length < 3){
      return 'Name must be at least 3 characters long';
    }
    return null;
  }
}