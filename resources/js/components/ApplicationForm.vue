<template>
  <section class="form-wrapper">
    <h1>Simple Application Form</h1>
    <form @submit.prevent="submitApplication">
      <label>
        Full name
        <input v-model="form.full_name" type="text" required />
      </label>

      <label>
        Email
        <input v-model="form.email" type="email" required />
      </label>

      <label>
        Phone
        <input v-model="form.phone" type="tel" required />
      </label>

      <label>
        Position
        <input v-model="form.position" type="text" required />
      </label>

      <label>
        Cover letter
        <textarea v-model="form.cover_letter" rows="5" />
      </label>

      <button :disabled="loading" type="submit">
        {{ loading ? 'Submitting...' : 'Submit Application' }}
      </button>
    </form>

    <p v-if="message" class="success">{{ message }}</p>
    <p v-if="error" class="error">{{ error }}</p>
  </section>
</template>

<script setup>
import { reactive, ref } from 'vue';

const loading = ref(false);
const message = ref('');
const error = ref('');

const form = reactive({
  full_name: '',
  email: '',
  phone: '',
  position: '',
  cover_letter: '',
});

const resetForm = () => {
  form.full_name = '';
  form.email = '';
  form.phone = '';
  form.position = '';
  form.cover_letter = '';
};

const submitApplication = async () => {
  loading.value = true;
  message.value = '';
  error.value = '';

  try {
    const response = await fetch('/api/applications', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
      },
      body: JSON.stringify(form),
    });

    const payload = await response.json();

    if (!response.ok) {
      throw new Error(payload.message || 'Unable to submit application.');
    }

    message.value = `${payload.message} ID: ${payload.application_id}`;
    resetForm();
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.form-wrapper {
  max-width: 640px;
  margin: 2rem auto;
  padding: 1.5rem;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  font-family: Arial, sans-serif;
}

h1 {
  margin-top: 0;
}

form {
  display: grid;
  gap: 1rem;
}

label {
  display: grid;
  gap: 0.4rem;
  font-weight: 600;
}

input,
textarea,
button {
  font: inherit;
  padding: 0.6rem;
}

button {
  background: #2563eb;
  color: #fff;
  border: 0;
  border-radius: 8px;
  cursor: pointer;
}

button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.success {
  color: #15803d;
}

.error {
  color: #b91c1c;
}
</style>
