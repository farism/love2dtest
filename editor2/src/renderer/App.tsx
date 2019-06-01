import * as React from 'react'
import { Avatar } from './ui/Avatar'
import { Banner } from './ui/Banner'
import { Box } from './ui/Box'
import { Button } from './ui/Button'
import { Checkbox } from './ui/Checkbox'
import { Icon } from './ui/Icon'
import { Input } from './ui/Input'
import { Link } from './ui/Link'
import { Modal } from './ui/Modal'
import { Panel } from './ui/Panel'
import { Popover } from './ui/Popover'
import { RadioButton } from './ui/RadioButton'
import { Search } from './ui/Search'
import { Slider } from './ui/Slider'
import { Spinner } from './ui/Spinner'
import { Switch } from './ui/Switch'
import { Table } from './ui/Table'
import { Tabs } from './ui/Tabs'
import { TextArea } from './ui/Textarea'
import { Toast } from './ui/Toast'
import { Token } from './ui/Token'
import { Tooltip } from './ui/Tooltip'
import { Wyswiwyg } from './ui/Wysiwyg'

export function App() {
  return (
    <div>
      <div>
        <Avatar>Avatar</Avatar>
      </div>
      <div>
        <Banner>Banner</Banner>
      </div>
      <div>
        <Box>Box</Box>
      </div>
      <div>
        <Button>Button</Button>
      </div>
      <div>
        <Checkbox>Checkbox</Checkbox>
      </div>
      <div>
        <Icon>Icon</Icon>
      </div>
      <div>
        <Input />
      </div>
      <div>
        <Link>Link</Link>
      </div>
      <div>
        <Modal>Modal</Modal>
      </div>
      <div>
        <Panel>Panel</Panel>
      </div>
      <div>
        <Popover>Popover</Popover>
      </div>
      <div>
        <RadioButton>Radio Button</RadioButton>
      </div>
      <div>
        <Search />
      </div>
      <div>
        <Slider>Slider</Slider>
      </div>
      <div>
        <Spinner>Spinner</Spinner>
      </div>
      <div>
        <Switch>Switch</Switch>
      </div>
      <div>
        <Table>Table</Table>
      </div>
      <div>
        <Tabs>Tabs</Tabs>
      </div>
      <div>
        <TextArea defaultValue="" />
      </div>
      <div>
        <Toast>Toast</Toast>
      </div>
      <div>
        <Token>Token</Token>
      </div>
      <div>
        <Tooltip>Tooltip</Tooltip>
      </div>
      <div>
        <Wyswiwyg>Wyswiwyg</Wyswiwyg>
      </div>
    </div>
  )
}
