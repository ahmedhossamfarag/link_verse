String? emailValidator(String? value){
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }
  if (value.length > 50) {
    return 'Name must be less than 50 characters';
  }
  return null;
}

String? titleValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a title';
  }
  if (value.length < 5) {
    return 'Title must be at least 5 characters long';
  }
  if (value.length > 20) {
    return 'Title must be less than 100 characters';
  }
  return null;
}

String? descriptionValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a description';
  }
  if (value.length < 10) {
    return 'Description must be at least 10 characters long';
  }
  if (value.length > 100) {
    return 'Description must be less than 1000 characters';
  }
  return null;
}

String? summaryValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a summary';
  }
  if (value.length < 10) {
    return 'Summary must be at least 10 characters long';
  }
  if (value.length > 500) {
    return 'Summary must be less than 500 characters';
  }
  return null;
}

String? uRlValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a URL';
  }
  if (!RegExp(r'^(https?)://[^\s/$.?#].[^\s]*$').hasMatch(value)) {
    return 'Enter a valid URL';
  }
  return null;
}