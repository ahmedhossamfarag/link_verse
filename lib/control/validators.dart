String? emailValidator(String? value){
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? confirmPasswordValidator(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'Please confirm your password';
  }
  if (value != password) {
    return 'Passwords do not match';
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

String? tagValidator(String? value, List<String> tags) {
  if (value == null || value.isEmpty) {
    return 'Please enter a tag';
  }
  if (value.length < 3) {
    return 'Tag must be at least 3 characters long';
  }
  if (value.length > 20) {
    return 'Tag must be less than 20 characters';
  }
  if (tags.contains(value)) {
    return 'Tag already exists';
  }
  if (value.contains("'") || value.contains('"')) {
    return 'Tag cannot contain quotes';
  }
  return null;
}

String? imageValidator(String? value, List<String> imageUrls) {
  if (value != null && imageUrls.contains(value)) {
    return 'Image already exists';
  }
  return uRlValidator(value);
}