/**
 * Validation utility functions for form inputs
 */

/**
 * Validates that a name contains only letters and spaces
 * @param name - The name to validate
 * @returns true if valid, false otherwise
 */
export function isValidName(name: string): boolean {
  if (!name || name.trim().length === 0) {
    return false;
  }
  // Only allow letters (including unicode letters) and spaces
  const nameRegex = /^[a-zA-Z\u00C0-\u024F\u1E00-\u1EFF\s]+$/;
  return nameRegex.test(name);
}

/**
 * Validates email format using standard email regex
 * @param email - The email to validate
 * @returns true if valid, false otherwise
 */
export function isValidEmail(email: string): boolean {
  if (!email || email.trim().length === 0) {
    return false;
  }
  // Standard email validation regex
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email.trim());
}

/**
 * Validates that a phone number contains only digits
 * @param phone - The phone number to validate (without country code)
 * @returns true if valid, false otherwise
 */
export function isValidPhone(phone: string): boolean {
  if (!phone || phone.trim().length === 0) {
    return false;
  }
  // Only allow digits (no letters or special characters except spaces which we'll strip)
  const phoneRegex = /^\d+$/;
  return phoneRegex.test(phone.trim().replace(/\s/g, ''));
}

/**
 * Get validation error message for name
 * @param name - The name to validate
 * @returns Error message or null if valid
 */
export function getNameError(name: string): string | null {
  if (!name || name.trim().length === 0) {
    return "Name is required";
  }
  if (!isValidName(name)) {
    return "Name can only contain letters and spaces";
  }
  return null;
}

/**
 * Get validation error message for email
 * @param email - The email to validate
 * @returns Error message or null if valid
 */
export function getEmailError(email: string): string | null {
  if (!email || email.trim().length === 0) {
    return "Email is required";
  }
  if (!isValidEmail(email)) {
    return "Please enter a valid email address";
  }
  return null;
}

/**
 * Get validation error message for phone
 * @param phone - The phone number to validate
 * @returns Error message or null if valid
 */
export function getPhoneError(phone: string): string | null {
  if (!phone || phone.trim().length === 0) {
    return "Phone number is required";
  }
  if (!isValidPhone(phone)) {
    return "Phone number can only contain digits";
  }
  return null;
}
