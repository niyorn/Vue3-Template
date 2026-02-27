import { onKeyStroke } from '@vueuse/core'
import { ref } from 'vue'

interface UseModalOptions {
  closeOnEscape?: boolean
}

export function useModal(options: UseModalOptions = {}) {
  const { closeOnEscape = true } = options

  const isOpen = ref(false)

  const open = (): void => {
    isOpen.value = true
  }

  const close = (): void => {
    isOpen.value = false
  }

  const toggle = (): void => {
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
