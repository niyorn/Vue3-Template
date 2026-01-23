import { onKeyStroke } from '@vueuse/core'
import { ref } from 'vue'

export function useModal(options = {}) {
  const { closeOnEscape = true } = options

  const isOpen = ref(false)

  const open = () => {
    isOpen.value = true
  }

  const close = () => {
    isOpen.value = false
  }

  const toggle = () => {
    isOpen.value = !isOpen.value
  }

  if (closeOnEscape) {
    onKeyStroke('Escape', () => {
      if (isOpen.value) {
        close()
      }
    })
  }

  return {
    isOpen,
    open,
    close,
    toggle,
  }
}
